#!/bin/bash

# define constant
WARN_LIMIT=30
INT_TODAY=$(date "+%Y%m%d")
INT_WARN=$(date -d "$WARN_LIMIT days" "+%Y%m%d")
SEND_TITLE="SSL Certificate Expiration Check ($(date -R))"
RESULTDIR=/home/tone001/checkcert/`date +%Y`/`date +%m`
RESULTFILE=/home/tone001/checkcert/`date +%Y`/`date +%m`/sendtxt.$(date "+%Y%m%d")
OS=`cat /etc/os-release | grep 'ID='`

# define color code
COLOR_RED="\e[1;31m"
COLOR_YEL="\e[1;33m"
COLOR_OFF="\e[00m"

# create result file
test -d $RESULTDIR || mkdir -p $RESULTDIR
test -f $RESULTFILE || touch $RESULTFILE

# define send mail function each OS
function send_mail_rhel()
{
  echo -e "Subject: `echo $SEND_TITLE`\n\n`echo $RESULTFILE`" | sendmail z23049kt@aiit.ac.jp
}

function send_mail_ubuntu()
{
  mailmail3 -s echo $SEND_TITLE z23049kt@aiit.ac.jp < $RESULTFILE
}

# define check expire cert function
function check_enddate()
{
  echo "" | openssl s_client -connect $1:443 2> /dev/null | openssl x509 -enddate -noout | sed 's/notAfter\=//'
}


# loop
for i in `cat $1`; do
  enddate=$(check_enddate ${i})
  int_end=$(date -d "$enddate" "+%Y%m%d")
  if [ $INT_TODAY -ge $int_end ]; then
    echo '==================' >> $RESULTFILE
    echo '!!!!!!!!!!!!!!!!!!' >> $RESULTFILE
    echo '[EMERG]' >> $RESULTFILE
    echo "${i} already expired on $enddate" >> $RESULTFILE
    echo 'Please update urgency!!' >> $RESULTFILE
    echo '!!!!!!!!!!!!!!!!!!' >> $RESULTFILE
    echo '' >> $RESULTFILE
  elif [ $INT_WARN -ge $int_end ]; then
    echo '==================' >> $RESULTFILE
    echo '[WARN]' >> $RESULTFILE
    echo "${i}  will expire on $enddate" >> $RESULTFILE
    echo "Please update in a week." >> $RESULTFILE
    echo '' >> $RESULTFILE
  else
    echo '==================' >> $RESULTFILE
    echo "${i} is no problem as for now." >> $RESULTFILE
    echo "Expire: $enddate" >> $RESULTFILE
    echo '' >> $RESULTFILE
  fi
done

# send result
if [[ "$OS" == *rocky* ]] || [[ "$OS" == *cent* ]]; then
  send_mail_rhel
elif [[ "$OS" == *ubuntu* ]]; then
  send_mail_ubuntu
fi