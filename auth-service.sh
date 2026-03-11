source common.sh
service_name=auth-service

echo -e "${YC}Install golang${NC}"
dnf install -y golang &>>$OUTPUT
status_check

echo -e "${YC}Update auth-service service file${NC}"
cp ${service_name}.service /etc/systemd/system/${service_name}.service &>>$OUTPUT
status_check

echo -e "${YC}Prepare application prerequisites${NC}" 
app_prereq

echo -e "${YC}Build auth service${NC}"
cd /app
CGO_ENABLED=0 go build -o ${service_name} ./cmd/server  &>>$OUTPUT
status_check

echo -e "${YC}Change user permissions${NC}"
chown -R appuser:appuser /app &>>$OUTPUT
chmod o-rwx /app -R &>>$OUTPUT
status_check

echo -e "${YC}Start auth service${NC}"
systemctl daemon-reload
systemctl enable ${service_name} &>>$OUTPUT
systemctl start ${service_name} &>>$OUTPUT
status_check