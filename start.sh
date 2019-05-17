#
#    SPDX-License-Identifier: Apache-2.0
#

#!/bin/bash
#
#Redirecting console.log to log file.
#Please visit ./logs/app to view the application logs and visit the ./logs/db to view the Database logs and visit the ./log/console for the console.log
# Log rotating for every 7 days.

rm -rf /tmp/fabric-client-kvs_peerOrg*

mkdir -p ./logs/app & mkdir -p ./logs/db & mkdir -p ./logs/console

LOG_CONSOLE_PATH="logs/console/console-$(date +%Y-%m-%d).log"

echo "************************************************************************************"
echo "**************************** Hyperledger Explorer **********************************"
echo "************************************************************************************"
echo "***** Please check the log [$LOG_CONSOLE_PATH] for any error *****"
echo "************************************************************************************"

set -e

# Print usage
function print_help() {
	echo "Usage: "
	echo "    main.sh <mode> - one of 'debug' 'help' "
	echo "            - 'debug' - prints to the console debug statements"
	echo "            - print this message"
}


function do_debug() {
	export HFC_LOGGING='{"debug":"console"}'
	(node main.js name - hyperledger-explorer >$LOG_CONSOLE_PATH ) 2>&1
	find ./logs/app -mtime +7 -type f -delete & find ./logs/db -mtime +7 -type f -delete & find ./logs/console -mtime +7 -type f -delete
}

function default(){
	node main.js name - hyperledger-explorer >>$LOG_CONSOLE_PATH  2>&1 &
	find ./logs/app -mtime +7 -type f -delete & find ./logs/db -mtime +7 -type f -delete & find ./logs/console -mtime +7 -type f -delete
}

# Get subcommand
SUBCOMMAND=$1
shift

case $SUBCOMMAND in
	debug)
 do_debug
	 ;;
	help)
 print_help
	 ;;
		*)
	default
	 ;;
esac



