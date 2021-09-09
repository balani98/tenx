import json
import pandas as pd
from sqlalchemy import create_engine
import argparse,textwrap
import traceback
import shutil
import time

try:
	#CSV and JSON details
	parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter,description=textwrap.dedent('''\
	Utility Usage :Python Script to read from excel and write to database
	-------------------------------------------------------------------------------
	* script path accepts file path of json as input
	* Script reads the data from excel and writes to mysql database        
	* Author : Divya
	* Version : 1.0
	* Create Date : 21-Oct-2016'''))

	parser.add_argument('--filename', action="store" , dest='json' , help='json file name' , required=True)    
	parser.add_argument('--uuid', action="store" , dest='uuid' , help='UUID of the step passed from nPrep' , required=True)
	parser.add_argument('--path', action="store" , dest='folder' , help='nPrep working folder path' , required=True)
	args = parser.parse_args()
    
	#method to read from excel
	def read_from_excel(action):
		connInfo = json_data["connectionInfo"]

		if action["from"]["excludeHeaders"] == True:
			df = pd.read_excel(connInfo["from"]["sourceExcelFile"],action["from"]["sourceSheetName"], skiprows=0, index_col=None, na_values=['NA'])
		else:        
			df = pd.read_excel(connInfo["from"]["sourceExcelFile"],action["from"]["sourceSheetName"],header=None,index_col=None, na_values=['NA'])

		print('Completed excel reading : '+ time.strftime('%H:%M:%S'))

		return df

	#method to write dataframe to mysql database
	def write_to_db(df,action):
		connInfo = json_data["connectionInfo"]

		host = connInfo["to"]["hostname"]
		port = connInfo["to"]["port"]
		db = connInfo["to"]["databaseName"]
		user = connInfo["to"]["user"]
		passwd = connInfo["to"]["password.xkcd"]    

		engine = create_engine('mysql+pymysql://'+user+':'+passwd+'@'+host+':'+str(port)+'/'+db+'?charset=utf8', encoding = 'utf-8',echo=False)
		cnx = engine.connect()

		print('Writing to database: ' + time.strftime('%H:%M:%S'))

		# Always truncate and load the data
		df.to_sql(name= action["to"]["temporaryTableName"], con=cnx, if_exists = 'replace', index=False, chunksize=1000)

		print('Successfully wrote to database table : '+action["to"]["temporaryTableName"] + time.strftime('%H:%M:%S') )
    
    #Read Json details
	with open(args.folder+args.json, 'r')as json_file:
		json_data=json.load(json_file)
		print('Json instructions loaded successfully!')
	json_file.close()

	#opening the output file
	output = open(args.folder+args.uuid+'-output.txt', "w")  
	status = open(args.folder+args.uuid+'.txt', "w")
	status.write('1');status.close()


	#Reading each action from json
	for action in json_data["actions"]:
		if(action["type"] == "sheetToTable"):
		#calling a method to read excel
			print('Reading excel :' + time.strftime('%H:%M:%S'))
			df = read_from_excel(action)
			write_to_db(df,action)

	#closing the output file
	print('closing the output file')
	output.close()
	print('Writing the status as 0 to status file')
	status = open(args.folder+args.uuid+'.txt', "w")
	status.write('0')
	print('Closing the status file')
	status.close()
    
except IOError:
    print('Error: Could not find file or read the data!'+str(traceback.format_exc()))
                
except Exception as error:
    print('Error Occured!'+str(traceback.format_exc()))