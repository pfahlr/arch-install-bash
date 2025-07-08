#!/usr/bin/bash

#source _vars.inc.sh

#continueyn

#echo "You walk into the room and see a kolbold beast waiting there, what do you say?:"
#read foo
#if [[ "hello" == "$foo" ]]; then
#	echo "the kolbold beast greets you with a cheerful \"well hello to you too\""
#else
#	echo "the kolbold beast responds \"what the fuck did you say to me?\" and then visciously gnaws off your genitals"
#fi
set -x
command="sed -i s+LABEL=swap+/dev/mapper/swap+ ./fstab-example"

eval $command
