#!/usr/bin/bash
###############################################################################
#####################            FUNCTIONS             ########################
###############################################################################

continueyn() {
  local answer=''
  echo "continue[y/n]"
  read answer
  if [[ $answer == 'y' ]]; then
	  return 1
  elif [[ $answer == 'n' ]]; then
	  exit 0
  else
	  echo "I don't understand"
	  continueyn
  fi

}
source _settings.inc.sh


