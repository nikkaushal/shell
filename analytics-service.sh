source common.sh
service_name=analytics-service

echo -e "${YC}Install Python${NC}"
dnf install -y python3.12 python3.12-pip python3.12-devel gcc &>>$OUTPUT
status_check

echo -e "${YC}Copy Service File${NC}"
cp ${service_name}.service /etc/systemd/system/${service_name}.service &>>$OUTPUT
status_check

echo -e "${YC}Download and Extract Application${NC}"
app_prereq
status_check

echo -e "${YC}Install Application Dependencies${NC}"
cd /app
pip3.12 install --no-cache-dir . &>>$OUTPUT
status_check

set_permissions

start_service