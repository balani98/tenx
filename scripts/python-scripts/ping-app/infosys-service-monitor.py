import traceback
import os
import pymysql
import subprocess
import socket
from properties.p import Property
import sys
import time
import configparser
import argparse
import smtplib
from datetime import datetime, timedelta
from collections import OrderedDict
from nproperty.prop import NProperty


os_type=''

count = 0
last_mail_sent_time	= 0
service_list_to_be_monitered = [] 
ip_monitor_services_list = {}
service_commandLine_strings = {}
zk = {}
quartz = {}
ip = socket.gethostbyname(socket.gethostname())
print(ip)
service_list={}
zk_ip_list = []
quartz_ip_list = []
ring_master_ip_list =[]
ring_worker_ip_list =[]

#variables used for messages
welcome_text = 'Welcome to nPrep Service Monitor Email Alert'
service_down = 'Service Down'
service_down_with_alert = 'Service Down with Email Alert'
service_down_cannot_alert = 'Service Down without Email : Limit Exceeded'
service_restarted = 'Service Restarted'
service_restart_failed = 'Service Restart Failed'
service_restart_failed_cannot_alert = 'Service Restart Failed without Email :Limit Exceeded'
service_restarted_with_alert = 'Service Restarted with Email Alert'
service_restarted_cannot_alert = 'Service Restarted without Email : Limit Exceeded'
max_email_limit = 'Maximum Email Limit reached. You will receive next email alert nearly at '
email_limit_crossed = 'Email Limit Exceeded'
try:
	parser = argparse.ArgumentParser(description='Utility to keep monitor services in ubuntu/windows')
	parser.add_argument('-cfg',
						action="store",
						dest='config_file',
						metavar='<config file name>',
						help='Config file name. Default is \'nprep-service-monitor.cfg\'.',
						default="infosys-service-monitor.cfg",
						required=False)
	args = parser.parse_args()
	config = configparser.ConfigParser()
	config.read(args.config_file)   
	
	#loading the property file from the config folder path
	p = NProperty()
	propertyfilepath=config.get("property_file_path", "propertyfilepath")
	propertydict = p.load_property_files(propertyfilepath)
	
	
	#fetch database credentails from config file
	hostname=propertydict["common.pingappdb.jdbc.url"].split('/')[2]
	portnumber = propertydict["common.pingappdb.port"]
	username = propertydict["common.pingappdb.user"]
	dbpassword = propertydict["common.pingappdb.password.xkcd"]
	database = propertydict["common.pingappdb.jdbc.url"].split('/')[3]	

	
	#fetch email configuration details from config file
	from_addr = propertydict["common.utils.monitor.mail.from"]
	to_addr_list = propertydict["common.utils.monitor.mail.to"]
	login = propertydict["common.utils.monitor.mail.from"]
	password = propertydict["common.utils.monitor.mail.password.xkcd"]
	smtpserver = propertydict["common.utils.monitor.mail.host"]
	smtpport = propertydict["common.utils.monitor.mail.port"]
	
	#fetch email limit per hour from config file
	limit = config.get("max_emails_limit_per_hour", "limit")
	
	#fetch ping time from config file
	pingtime = config.get("ping_time", "pingtime")
	
	#fetch services to be monitered from config file
	zk = config.getboolean("services_to_be_monitered", "zk")
	quartz = config.getboolean("services_to_be_monitered" , "quartz")	
	ring_master = config.getboolean("services_to_be_monitered" , "ring-master")	
	ring_worker = config.getboolean("services_to_be_monitered" , "ring-worker")		
		
	#checking for sevices to be monitored is true from config file and adding to list
	if zk == True:
		service_list_to_be_monitered.append('zk')
	if quartz == True:
		service_list_to_be_monitered.append('quartz')	
	if ring_master == True:
		service_list_to_be_monitered.append('ring-master')		
	if ring_worker == True:
		service_list_to_be_monitered.append('ring-worker')			

	#fetch root paths for restarting services from config file
	root_path_zk_kafka = config.get("Launch_Strings" , "root_path_zk_kafka")	
	root_path_quartz = config.get("Launch_Strings" , "root_path_quartz")
	root_path_ring_master_worker = config.get("Launch_Strings" , "root_path_ring_master_worker")
	root_path_ring_master_worker_windows = config.get("Launch_Strings" , "root_path_ring_master_worker_windows")
	
	#fetching command for restarting services from config file
	cmd_for_starting_zookeeper = config.get("Launch_Strings" , "cmd_for_starting_zookeeper")		
	cmd_for_starting_quartz = config.get("Launch_Strings" , "cmd_for_starting_quartz")
	cmd_for_starting_ring_master = config.get("Launch_Strings" , "cmd_for_starting_ring_master")		
	cmd_for_starting_ring_master_windows = config.get("Launch_Strings" , "cmd_for_starting_ring_master_windows")	
	cmd_for_starting_ring_worker = config.get("Launch_Strings" , "cmd_for_starting_ring_worker")	
	cmd_for_starting_ring_worker_windows = config.get("Launch_Strings" , "cmd_for_starting_ring_worker_windows")	
	
	#fetch keywords for services to be monitored from config file
	service_commandLine_strings=OrderedDict()
	service_commandLine_strings.update(OrderedDict(config.items('CommandLine_Strings')))

	#fetch serivice output path from config file
	filepath = config.get("service_output_filepath" , "servicefilepath")	
	
	#getting services to be monitered on different ip's from property file
	zk_ip_list=propertydict["common.zk.hosts"].split(',')
	zk = OrderedDict((ip.split(':')[0].replace('[','').replace(']','').strip(),'21') for ip in zk_ip_list )

	quartz_ip_list=propertydict["common.quartz.hosts"].split(',')
	quartz = OrderedDict((ip.split(':')[0].replace('[','').replace(']','').strip(),'21') for ip in quartz_ip_list )
	
	ring_master_ip_list=propertydict["common.ring.master.hosts"].split(',')
	ring_master = OrderedDict((ip.split(':')[0].replace('[','').replace(']','').strip(),'21') for ip in ring_master_ip_list )
	
	ring_worker_ip_list=propertydict["common.ring.worker.hosts"].split(',')
	ring_worker = OrderedDict((ip.split(':')[0].replace('[','').replace(']','').strip(),'21') for ip in ring_worker_ip_list )

	
	#method to get the ip addresses for each service to be monitered
	def get_ip_monitor_service_list():
		ip_monitor_services_list=OrderedDict()
		for key,value in zk.items():
			if key == ip:
				ip_monitor_services_list['zk'] = value

		for key,value in quartz.items():
			if key == ip:
				ip_monitor_services_list['quartz'] = value	

		for key,value in ring_master.items():
			if key == ip:
				ip_monitor_services_list['ring-master'] = value	

		for key,value in ring_worker.items():
			if key == ip:
				ip_monitor_services_list['ring-worker'] = value	

		return ip_monitor_services_list

	print('tes')	
	print(ip_monitor_services_list)
	
	#method to send email
	def sendemail(from_addr, to_addr_list,subject, message,login, password,smtpserver, smtpport):  # split smtpserver and -port
		global count
		global last_mail_sent_time
		key_name = subject.split(' ')
		to_addr_list = list(to_addr_list.split(","))
		header  = 'From: %s\n' % from_addr
		header += 'To: %s\n' % ','.join(to_addr_list)
		#header += 'Cc: %s\n' % ','.join(cc_addr_list)
		#print(count)
		if count == int(limit) :
			subject = subject+ '-'+ email_limit_crossed
			header += 'Subject: %s\n\n' % subject 
		else:
			header += 'Subject: %s\n\n' % subject
		failedmessage=message
		message = header + message
		server = smtplib.SMTP(smtpserver, smtpport)  # use both smtpserver  and -port 
		server.starttls()
		server.login(login,password)

		#check if the count is less than email limit
		if  count < int(limit) :
			problems = server.sendmail(from_addr, to_addr_list, message)
			last_mail_sent_time= datetime.now()
			count = count+1
		#check if count is equal to email limit and send alert with service down and email limit exceeded alert
		elif  count == int(limit) :
			email_limit_message= message +'\n\n'+max_email_limit+' ' +str(datetime.now()+timedelta(hours = 1))
			problems = server.sendmail(from_addr,to_addr_list,email_limit_message)
			last_mail_sent_time= datetime.now()
			count = count+1
			#event_log(key_name[1],email_limit_crossed,'')
			
		#print(datetime.now() - last_mail_sent_time)
		if (datetime.now() - last_mail_sent_time) > timedelta(hours = 1):
			print('\nresetting counter back to 0')
			count = 0			
		server.quit()
	
	#method to get database connection
	def connection():
		conn = pymysql.connect(host=hostname, port=int(portnumber), user=username, passwd=dbpassword, db=database,autocommit=True)
		return conn	
	
	#method to insert/update ping details in the database for each services
	def insert_update_ping(key):
		conn = connection()
		cur = conn.cursor(pymysql.cursors.DictCursor)
		print("\nConnected to database to insert or update ping details for service : "+str(key))	
		try:
			if pingtime :
				cur.execute("call tenx_services_monitor.pingtransaction('"+str(key)+"','"+ip+"','"+pingtime+"')")		
		except:
			conn.rollback()
			print('Exception Occured!!!! - Transaction rolled back'+str(traceback.format_exc()))
		finally:
			conn.close()
			
	#method to log events of each services
	def event_log(key, event_name,event_details):
		conn = connection()
		cur = conn.cursor(pymysql.cursors.DictCursor)		
		print("\nConnected to database to update event log for service : "+str(key))	
		try:
			cur.execute("insert into tenx_services_monitor.event_log(ip,service_name,event_name,details,timestamp) values ('"+ip+"','"+str(key)+"','"+event_name+"','"+event_details.replace('\'', '\\\'')+"',now())")		
		except:
			conn.rollback()
			print('Exception Occured!!!! - Transaction rolled back'+str(traceback.format_exc()))
		finally:
			conn.close()

	#method to restart services			
	def restart_service(service_id):
		#print('inside restart service method')
		try:
			if service_id == 'zk': #restart Zookeeper
				os.chdir(root_path_zk_kafka)
				print (time.strftime("%d-%m-%Y--%H:%M:%S ----- ") + "............Restarting Zookeeper............", end=""'\n')
				os.popen(cmd_for_starting_zookeeper)
				#subprocess.Popen(cmd_for_starting_zookeeper, creationflags=subprocess.CREATE_NEW_CONSOLE)
				
			elif service_id == 'quartz':#restart Quartz
				os.chdir(root_path_quartz)
				print (time.strftime("%d-%m-%Y--%H:%M:%S ----- ") + "............Restarting Quartz............", end=""'\n')				#subprocess.Popen(cmd_for_starting_quartz, creationflags=subprocess.CREATE_NEW_CONSOLE)
				os.system(cmd_for_starting_quartz)	
				
			elif service_id == 'ring-master':#restart ring-master
				if os.name.lower() == 'nt' :
					os.chdir(root_path_ring_master_worker_windows)
					print(time.strftime("%d-%m-%Y--%H:%M:%S ----- ") + "............Restarting ring-master-windows............", end=""'\n')
					subprocess.Popen(cmd_for_starting_ring_master_windows, creationflags=subprocess.CREATE_NEW_CONSOLE)
				elif os.name.lower() == 'posix':
					os.chdir(root_path_ring_master_worker)
					print(time.strftime("%d-%m-%Y--%H:%M:%S ----- ") + "............Restarting ring-master............", end=""'\n')
					os.system(cmd_for_starting_ring_master)				
				
			elif service_id == 'ring-worker':#restart ring-worker
				if os.name.lower() == 'nt' :
					os.chdir(root_path_ring_master_worker_windows)
					print(time.strftime("%d-%m-%Y--%H:%M:%S ----- ") + "............Restarting ring-worker-windows............", end=""'\n')
					subprocess.Popen(cmd_for_starting_ring_worker_windows, creationflags=subprocess.CREATE_NEW_CONSOLE)
				elif os.name.lower() == 'posix':
					os.chdir(root_path_ring_master_worker)
					print(time.strftime("%d-%m-%Y--%H:%M:%S ----- ") + "............Restarting ring-worker............", end=""'\n')
					os.system(cmd_for_starting_ring_worker)
				
			return(True)
		except Exception as error:
			return(str(traceback.format_exc()))
			
			print('Error Occured!'+str(traceback.format_exc()))			
			
	#method to get the configured downtime from nprep property file
	def get_config_downtime_period():
		try:
			#print("\nGet config downtime period in method : get_config_downtime_period")	
			if os.path.exists('/tenx/config/ring-nprep.properties'):
				os.chdir('/tenx/config')
				prop = Property()
				dic_prop = prop.load_property_files('ring-nprep.properties')
				downtime=dic_prop['downtime']
			return downtime
		except IOError:
			print('Error: Could not find file or read the data!'+str(traceback.format_exc()))						
		except:
			print('Exception Occured!!!! - Transaction rolled back'+str(traceback.format_exc()))

	#method to check the process.txt file for keys of services
	def check_for_keyword():
		try:
			global count
			#print("\nLooping through process file and check for keyword  : check_for_keyword")	
			#checking for file path
			ip_monitor_services_list=get_ip_monitor_service_list()
			print('hiiii')
			print(ip_monitor_services_list)
			service_list = OrderedDict((key,value) for key,value in service_commandLine_strings.items() if key in service_list_to_be_monitered and key in ip_monitor_services_list)
			#print(service_list)
			print('\nServices to be monitered : '+str([key for key in service_list]).strip("[]"))
			#print(service_list)
			if service_list:		
				if os.path.exists(filepath):
					#Looping through process log file
					with open(filepath) as processLog:
						for key, value in service_list.items():
							found_value = False
							processLog.seek(0)
							for line in processLog:
								if value in line :
									found_value = True
									insert_update_ping(key)
									break	
						
							if found_value == False:
								if ip_monitor_services_list[key] == '10': #monitor without supervision without email
									print('\n'+socket.gethostbyname(socket.gethostname()) +': '+key+ ' is down\n')
									event_log(key,service_down,'')
									
								elif ip_monitor_services_list[key] == '11': #monitor without supervision with email
									print('\n'+socket.gethostbyname(socket.gethostname()) +': '+key+ ' is down\n')
									subject= socket.gethostbyname(socket.gethostname()) + ': '+key+ ' is down'
									sendemail(from_addr, to_addr_list, subject , welcome_text, login, password,smtpserver, smtpport)					
									if count > int(limit) :
										event_log(key,service_down_cannot_alert,'')
									elif count == int(limit) :
										event_log(key,service_down+'-'+email_limit_crossed,'')
									else:
										event_log(key,service_down_with_alert,'')
									
								elif ip_monitor_services_list[key] == '20': #monitor with supervision without email
									print('\n'+socket.gethostbyname(socket.gethostname()) +': '+key+ ' is down and restarting\n')
									status=restart_service(key)
									if status == True :
										event_log(key,service_restarted,'')
									else:
										event_log(key,service_restart_failed,status)
									
								elif ip_monitor_services_list[key] == '21': #monitor with supervision with email
									print('\n'+socket.gethostbyname(socket.gethostname()) +': '+key+ ' is down and restarting\n')
									status=restart_service(key)
									if status == True :
										if count > int(limit) :
											event_log(key,service_restarted_cannot_alert,'')
										elif count == int(limit) :
											event_log(key,service_restarted+'-'+ email_limit_crossed,'')
										else:
											event_log(key,service_restarted_with_alert,'')
										subject= socket.gethostbyname(socket.gethostname()) + ': '+key+ ' is down and restarted'
										sendemail(from_addr, to_addr_list, subject , welcome_text, login, password,smtpserver, smtpport)							
									else:	
										if count > int(limit) :
											event_log(key,service_restart_failed_cannot_alert,status)
										elif count == int(limit) :
											event_log(key,service_restart_failed+'-'+ email_limit_crossed,status)
										else:
											event_log(key,service_restart_failed,status)
										subject= socket.gethostbyname(socket.gethostname()) + ': '+key+ ' is down and restart failed'
										sendemail(from_addr, to_addr_list, subject , welcome_text+'\n'+str(status), login, password,smtpserver, smtpport)							
									
					processLog.close()
				else:
					print('Invalid file path'+filepath)
		except IOError:
			print('Error: Could not find file or read the data!'+str(traceback.format_exc()))
						
		except Exception as error:
			print('Error Occured!'+str(traceback.format_exc()))

	#method to get running processes from ubuntu/windows and store it in process.txt file
	def get_running_processes():
		try:
			#print("\nFetching running processes  : get_running_processes")
			#deleting the process logs if already exists
			if not os.path.isdir('/tenx/working/services'):
				os.makedirs('/tenx/working/services')
			#if os.path.exists(filepath):
				#print('deleting process file')
				#os.remove(filepath)
			os.chdir('/tenx/working/services')
			if os.name.lower() == 'posix':
				os_type = 'posix'
				#fetching all processes into process.txt file
				process = subprocess.Popen("ps -f -C java > process.txt",shell=True,stdout=subprocess.PIPE)
				process.communicate()[0]		
			elif os.name.lower()=='nt':
				os_type = 'nt'
				#fetching all processes into process.txt file
				command = 'WMIC PROCESS where caption=\"java.exe\" get Processid,Commandline'
				process_output = subprocess.check_output(command) 
				process_output= process_output.decode(sys.stdout.encoding)
				process_output = process_output.splitlines()
				with open("process.txt", "w") as f:
					for value in process_output:
						f.write(value)
						f.write('\n')
			
		except IOError:
			print('Error: Could not find file or read the data!'+str(traceback.format_exc()))
						
		except Exception as error:
			print('Error Occured!'+str(traceback.format_exc()))	
		
	#Main program 
	def _main_():
		while(True):		
			print('--------------------------------------------------------------------------------')
			print('                     WELCOME TO RING SERVICE MONITOR APP                       ')
			print('--------------------------------------------------------------------------------')	
			#function call to get all the running processes in text file
			get_running_processes()
			#function to check if service is required service is running
			check_for_keyword()
			time.sleep(int(pingtime))
			
	_main_()

except IOError:
	print('Error: Could not find file or read the data!'+str(traceback.format_exc()))
                
except Exception as error:
	print('Error Occured!'+str(traceback.format_exc()))