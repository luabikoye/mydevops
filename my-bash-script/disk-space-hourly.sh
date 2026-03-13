#!/bin/bash
THRESHOLD=10
EMAIL="luabikoye@yahoo.com"

# Check disk usage
USAGE=$(df / | awk 'NR==2 {print $5}' | cut -d'%' -f1)

if [ "$USAGE" -gt "$THRESHOLD" ]; then
    SUBJECT="Disk Space Alert: ${USAGE}% used"
    BODY="Disk usage is ${USAGE}% on / partition

$(df -h)"

    # Send email with subject header
    echo -e "Subject: $SUBJECT\n\n$BODY" | msmtp $EMAIL
fi


#to run script above on servers
# sudo apt install msmtp msmtp-mta -y      # Ubuntu/Debian
# sudo yum install msmtp -y                # CentOS/RHEL

# #Create file and update values below /etc/msmtprc
# defaults
# auth           on
# tls            on
# tls_trust_file /etc/ssl/certs/ca-certificates.crt
# logfile        /var/log/msmtp.log
# 
# # Gmail account
# account        gmail
# host           smtp.gmail.com
# port           587
# from           yourgmail@gmail.com
# user           yourgmail@gmail.com
# password       YOUR_APP_PASSWORD
# 
# # Set default account
# account default : gmail
