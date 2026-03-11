source common.sh
service_name=portfolio-service

echo -e "${YC}Install java{NC}"
dnf install -y java-21-openjdk-devel &>>$OUTPUT
status_check

echo -e "${YC}Update portfolio-service service file${NC}"
cp ${service_name}.service /etc/systemd/system/${service_name}.service &>>$OUTPUT
status_check

echo -e "${YC}Prepare application prerequisites${NC}" 
app_prereq
status_check

echo -e "${YC}Change user permissions${NC}"
cd /app
chmod +x gradlew &>>$OUTPUT
./gradlew bootJar --no-daemon -x test &>>$OUTPUT
status_check

echo -e "${YC}Copy jar files and change appuser permsisions${NC}"
cp /app/build/libs/*.jar /app/${service_name}.jar &>>$OUTPUT
chown -R appuser:appuser /app &>>$OUTPUT
chmod o-rwx /app -R &>>$OUTPUT
status_check

echo -e "${YC}Start portfolio-service${NC}"
systemctl daemon-reload
systemctl enable ${service_name}
systemctl start ${service_name}
status_check
