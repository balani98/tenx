import codecs
import argparse,textwrap
import traceback

parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter,description=textwrap.dedent('''\
	Utility Usage :Python Script to read from excel and write to database
	-------------------------------------------------------------------------------
	* script path accepts input file path
	* Script reads csv with differnt encoding and outputs a file with utf-8 format     
	* Author : Divya
	* Version : 1.0
	* Create Date : 29-Jun-2018'''))
	
parser.add_argument('--inputfilepath', action="store" , dest='inputfilepath' , help='inputfilepath' , required=True)   
parser.add_argument('--outputfilepath', action="store" , dest='outputfilepath' , help='outputfilepath' , required=True)
parser.add_argument('--uuid', action="store" , dest='uuid' , help='UUID of the step passed from nPrep' , required=True)
parser.add_argument('--path', action="store" , dest='folder' , help='nPrep working folder path' , required=True) 	
args = parser.parse_args()
BLOCKSIZE = 1048576 # or some other, desired size in bytes
try:
	with codecs.open(args.inputfilepath, 'r', 'Utf-16') as sourceFile:
		with codecs.open(args.outputfilepath, "w", "utf-8") as targetFile:
			while True:
				contents = sourceFile.read(BLOCKSIZE)
				if not contents:
					break
				targetFile.write(contents)

				
	#opening the output file
	output = open(args.folder+args.uuid+'-output.txt', "w")  
	status = open(args.folder+args.uuid+'.txt', "w")
	status.write('1');status.close()
	#closing the output file
	print('closing the output file')
	output.close()
	print('Writing the status as 0 to status file')
	status = open(args.folder+args.uuid+'.txt', "w")
	status.write('0')
	print('Closing the status file')
	status.close()
	print('File converted to UTF-8 successfully')

except IOError:
	print('Error: Could not find file or read the data!'+str(traceback.format_exc()))
                
except Exception as error:
	print('Error Occured!'+str(traceback.format_exc()))
	with open(args.path+args.uuid+'.txt',"w") as fileStatus:
		fileStatus.write('1')