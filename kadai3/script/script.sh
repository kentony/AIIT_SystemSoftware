#!/bin/bash
       _DATE_=$(date +%Y%m%d_%H%M%S)
       _HOME_='/home/tone001'
    _WORKLOG_="${_HOME_}/worklog"
_WORKLOGFILE_="${_WORKLOG_}/${_DATE_}.log"

# create worklog dir
test -d ${_WORKLOG_} || mkdir -p ${_WORKLOG_}

# get worklog
if [ -e ${_WORKLOGFILE_} ]; then
  echo "\!\!WORK CONTIMUE FROM ${_DATE_} \!\!" >> ${_WORKLOGFILE_}
  script -a ${_WORKLOGFILE_}
else
  echo "\!\!WORK START FROM ${_DATE_} \!\!" >> ${_WORKLOGFILE_}
  script ${_WORKLOGFILE_}
fi