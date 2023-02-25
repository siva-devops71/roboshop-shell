source common.sh

mysql_root_password=$1
if [ -z "${mysql_root_password}" ]; then
  echo -e "\e[31mMissing Mysql Root Password argument\e[0m"
  exist 1
fi


print_head "Disabling Mysql 8 version"
dnf module disable mysql -y &>>${log_file}
status_check $?

print_head "copy Mysql repo file"
cp ${code_dir}/configs/mysql.repo /etc?yum.repos.d/mysql.repo &>>${log_file}
status_check $?

print_head "Installing Mysql server"
yum install mysql-community-server -y &>>${log_file}
status_check $?

print_head "Enable Mysql Service"
systemctl enable mysqld &>>${log_file}
status_check $?

print_head "Start Mysql Service"
systemctl start mysqld &>>${log_file}
status_check $?


print_head "Set Root Password"
echo show databases | mysql -uroot -p{mysql_root_password} &>>${log_file}
if [ $? -ne 0 ]; then
    mysql_secure_installation --set-root-pass {mysql_root_password} &>>${log_file}
fi
status_check $?