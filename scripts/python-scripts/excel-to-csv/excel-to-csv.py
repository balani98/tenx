import pandas as pd
import numpy as np
import os
import sys
import xlrd
import re
import argparse
import logging
import os.path
 

#--input_file_full_path D:/Projects/acme/AR/ar1.xlsm --output_file_full_path D:/Projects/acme/AR/ar1.csv --sheet_name Reports --header 22 --uuid 1234 --path D:/Projects/acme/AR/

parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter)

parser.add_argument('--input_file_full_path' , action="store", dest='input_file_full_path' , required=True)
parser.add_argument('--output_file_full_path' , action="store", dest='output_file_full_path' , required=True)
parser.add_argument('--sheet_name' , action="store", dest='sheet_name' , required=False, default='Sheet 1')
parser.add_argument('--header' , action="store", dest='header' , required=False, default=0)
parser.add_argument('--skiprows' , action="store", dest='skiprows' , required=False, default=0)
parser.add_argument('--skip_footer' , action="store", dest='skip_footer' , required=False, default=0)

parser.add_argument('--uuid', action="store" , dest='uuid' , help='UUID of the step passed from nPrep' , required=True)
parser.add_argument('--path', action="store" , dest='path' , help='nPrep working folder path' , required=True)
args = parser.parse_args()

try:
	if os.path.isfile(args.input_file_full_path):
		
		#READ EXCEL FILE
		xls = pd.ExcelFile(args.input_file_full_path)
		df = xls.parse(args.sheet_name, header=int(args.header), skiprows=int(args.skiprows), skip_footer=int(args.skip_footer), index_col=None, na_values=['NA'])
		
		#PRODUCE OUTPUT CSV FILE
		df.to_csv(args.output_file_full_path, sep=',', index=False, quotechar='"',encoding='utf-8')
		
		#write status into semaphore output file
		print('Writting script-execution-status into semaphore status file')
		with open(args.path+args.uuid+'.txt', "w") as fileStatus:
			fileStatus.write('0')
		
		with open(args.path+args.uuid+'-output.txt', "w") as output:
			output.write('')
		
		print('Process Completed!')
	else:
		raise Exception('Could not find file! Filename : ' + args.input_file_full_path)
	
except Exception as e:
	print(e)
	logging.exception("Something awful happened!")
	with open(args.path+args.uuid+'.txt', "w") as fileStatus:
		fileStatus.write('1')
