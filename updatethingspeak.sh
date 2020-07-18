#!/bin/bash
RETRIES=5
VAL=$(tail -n 1 /home/pi/waage04.dat | awk '{print $3}')
if [[ -z "$1" ]]
then
	FLD=1
else
	FLD=$1
fi

LOG=/home/pi/thingspeak.log
x=${RETRIES}
echo "$(date '+%Y-%m-%d %H:%M:%S') thingspeak update" >> ${LOG}
until [[ $(curl -d "key=NRYBWMETRTZ2Q2DJ&field${FLD}=${VAL}" -k http://api.thingspeak.com/update) -ne 0 ]] || [[ $x -lt 0 ]] 
do
  echo "$(date '+%Y-%m-%d %H:%M:%S') thingspeak update Versuch ${x}..." >> ${LOG}
  echo ${x}
  x=$(($x-1))
  sleep 15
done  

