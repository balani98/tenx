import sys
import os
import argparse,textwrap
from random import choice
from string import ascii_uppercase
import glob
import csv
from xlsxwriter.workbook import Workbook

#--inputfile C:/Users/stephen.r/Desktop/t/ip.txt --uuid 1234 --path C:/Users/stephen.r/Desktop/t/
#--inputfile /mnt/net/ndrive/partition-0/clients/infosys/eloqua/account-report/zk-backlog-5be3abc8-d044-416b-b9a9-ae5ce41474f0_0.txt --uuid 1234 --path /mnt/apps/nprep/working/

parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter)
parser.add_argument('--inputfile' , action="store", dest='inputfile' , required=True)
parser.add_argument('--uuid', action="store" , dest='uuid' , help='UUID of the step passed from nPrep' , required=True)
parser.add_argument('--path', action="store" , dest='path' , help='nPrep working folder path' , required=True)


args = parser.parse_args()

print('Arguments Received : ')
print('------------------')
print(args)

try:

	#open input file
	inputfilePath = args.inputfile
	basefileName = os.path.basename(inputfilePath)
	fileNameWOExtension =  os.path.splitext(basefileName)[0]
	fileDir = os.path.dirname(inputfilePath)
	
	fichier = open(inputfilePath, "rb")
	inputData = fichier.read()

	#decode input data 
	udata = inputData.decode("utf-16")
	fichier.close()

	#encode with ascii
	asciidata=udata.encode("ascii","ignore")

	#write new file with ascii encoded data
	outputfilePath = fileDir + '/' + 'temp-' + ''.join(choice(ascii_uppercase.lower()) for i in range(5)) + '-' + fileNameWOExtension+".csv"
	
	fichierTemp = open(outputfilePath, "wb")
	fichierTemp.write(asciidata)
	fichierTemp.close()
	
	#write csv into an excel file
	print('writing into excel...')
	exceoutputfilePath = os.path.join(fileDir, 'account_report.xlsx')
	try:
		os.remove(exceoutputfilePath)
	except:
		print('WARNING : file doesnt exists!! '  + exceoutputfilePath)
	
	try:
		workbook = Workbook(exceoutputfilePath)
		worksheet = workbook.add_worksheet('Account Report')
		with open(outputfilePath, 'r') as f:
			reader = csv.reader(f)
			for r, row in enumerate(reader):
				if r > 1:
					for c, col in enumerate(row):
						worksheet.write(r-2, c, col)
		
		workbook.close()
	except Exception as e:
		os.remove(exceoutputfilePath)
		
	print('excel file created!')
	os.remove(outputfilePath)
	
	#write status into semaphore output file
	print('Writting script-execution-status into semaphore status file')
	with open(args.path+args.uuid+'.txt', "w") as fileStatus:
		fileStatus.write('0')
		
	with open(args.path+args.uuid+'-output.txt', "w") as output:
		output.write('')

	print('SUCCESS!! Process completed.')
	
except Exception as e:
	print('Error Occured !!!!'+str(e))
	try:
		os.remove(outputfilePath)
	except:
		print('WARNING : file doesnt exists!! '  + exceoutputfilePath)
	#logging.exception("Something awful happened!")
	with open(args.path+args.uuid+'.txt', "w") as fileStatus:
		fileStatus.write('1')