#!/bin/bash

TF_PATH=/root/tinkerforge
TF_CALL="${TF_PATH}/tinkerforge call"
PRM_PATH=/var/lib/prometheus/node-exporter
TMP_FILE=$PRM_PATH/tinkerforge.prom.tmp
PRM_FILE=$PRM_PATH/tinkerforge.prom

### target sensors ###
air_quality_bricklet=""
temperature_bricklet=""
humidity_bricklet=""
ambient_light_v2_bricklet=""
dust_detector_bricklet=""

### start
echo "# tinkerfoge sensor values" | tee $TMP_FILE

### air-quality-bricklet ###
if [[ $air_quality_bricklet = "" ]] ; then
  echo "air-quality-bricklet is n/a"
else
  TFID="$air_quality_bricklet"
  #temperture
  OUTPUT=`$TF_CALL air-quality-bricklet $TFID get-temperature`
  ITEM=tinkerforge_`echo $OUTPUT | cut -d"=" -f1`
  VALUE=`echo $OUTPUT | cut -d"=" -f2`
  VALUE=`bc <<< "scale=2; $VALUE/100"`
  echo $ITEM $VALUE | tee -a $TMP_FILE

  #humidity
  OUTPUT=`$TF_CALL air-quality-bricklet $TFID get-humidity`
  ITEM=tinkerforge_`echo $OUTPUT | cut -d"=" -f1`
  VALUE=`echo $OUTPUT | cut -d"=" -f2`
  VALUE=`bc <<< "scale=2; $VALUE/100"`
  echo $ITEM $VALUE | tee -a $TMP_FILE

  #air-pressure
  OUTPUT=`$TF_CALL air-quality-bricklet $TFID get-air-pressure`
  #ITEM=tinkerforge_`echo $OUTPUT | cut -d"=" -f1`
  ITEM=tinkerforge_air_pressure
  VALUE=`echo $OUTPUT | cut -d"=" -f2`
  VALUE=`bc <<< "scale=2; $VALUE/100"`
  echo $ITEM $VALUE | tee -a $TMP_FILE
fi

### temperature-bricklet ###
if [[ $temperature_bricklet = "" ]] ; then
  echo "temperature-bricklet is n/a"
else
  TFID=$temperature_bricklet
  OUTPUT=`$TF_CALL temperature-bricklet $TFID get-temperature`
  ITEM=tinkerforge_`echo $OUTPUT | cut -d"=" -f1`
  VALUE=`echo $OUTPUT | cut -d"=" -f2`
  VALUE=`bc <<< "scale=2; $VALUE/100"`
  echo $ITEM $VALUE | tee -a $TMP_FILE
fi

### humidity-bricklet ###
if [[ $humidity_bricklet = "" ]] ; then
  echo "humidity-bricklet is n/a"
else
  TFID=$humidity_bricklet
  OUTPUT=`$TF_CALL humidity-bricklet $TFID get-humidity`
  ITEM=tinkerforge_`echo $OUTPUT | cut -d"=" -f1`
  VALUE=`echo $OUTPUT | cut -d"=" -f2`
  VALUE=`bc <<< "scale=2; $VALUE/100"`
  echo $ITEM $VALUE | tee -a $TMP_FILE
fi

### ambient-light-v2-bricklet ###
if [[ $ambient_light_v2_bricklet = "" ]] ; then
  echo "ambient-light-v2-bricklet is n/a"
else
  TFID=$ambient_light_v2_bricklet
  OUTPUT=`$TF_CALL ambient-light-v2-bricklet $TFID get-illuminance`
  ITEM=tinkerforge_`echo $OUTPUT | cut -d"=" -f1`
  VALUE=`echo $OUTPUT | cut -d"=" -f2`
  VALUE=`bc <<< "scale=2; $VALUE/100"`
  echo $ITEM $VALUE | tee -a $TMP_FILE
fi

### dust-detector-bricklet ###
if [[ $dust_detector_bricklet = "" ]] ; then
  echo "dust-detector-bricklet is n/a"
else
  TFID=$dust_detector_bricklet
  OUTPUT=`$TF_CALL dust-detector-bricklet $TFID get-dust-density`
  ITEM=tinkerforge_dust_density
  VALUE=`echo $OUTPUT | cut -d"=" -f2`
  echo $ITEM $VALUE | tee -a $TMP_FILE
fi

mv $TMP_FILE $PRM_FILE
