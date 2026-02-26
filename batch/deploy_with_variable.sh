#!/bin/bash


git_url="https://github.com/Aledoy-Developers/starsandbloom/archive/refs/heads/main.zip"
repo_file_name="starsandbloom"
dbname="starsbloom"
dbuser="starsbloom"
dbpass="valentine"
dbdump="starsandbloom_starsbloom.sql"
osapache="apache2"


#Update Server
sudo apt update




#install wget and zip
sudo apt install wget zip -y




#install apache2 and check firewall status
sudo apt install $osapache -y
sudo ufw app list








#restart Apache
sudo systemctl restart $osapache




echo
echo "####################################"
echo "Apache Server installed successfully"
echo "####################################"












#Pull project from gits
sudo wget $git_url




unzip main.zip




#remove default index.html in server directory
sudo rm -rf /var/www/html/index.html




#copy project to server directory
sudo cp -r $repo_file_name-main/* /var/www/html/




echo
echo "###############################################"
echo "Website files downloaded to server successfully"
echo "###############################################"








#install mysql
sudo apt install mysql-server -y












#create database
sudo mysql -u root -e "CREATE DATABASE $dbname;"




#create a user
sudo mysql -u root -e "CREATE USER '$dbuser'@'localhost' IDENTIFIED BY '$dbpass';"




#grant user all privileges to database
sudo mysql -u root -e "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER ON $dbname.* TO '$dbuser'@'localhost';"
sudo mysql -u root -e 'FLUSH PRIVILEGES;'








#import database from project folder
sudo mysql -u root $dbname < /var/www/html/$dbdump








echo
echo "################################"
echo "MYSQL installed with DB imported"
echo "################################"








#install php
sudo apt install php libapache2-mod-php php-mysql -y
php -v




echo
echo "################################"
echo "PHP installed successfully"
echo "################################"




#restart Apache
sudo systemctl restart apache2




echo
echo "#########################################"
echo "Server Restarted and Everything Live!!!!!"
echo "#########################################"













