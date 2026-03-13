source common.sh
service_name=portfolio-service

echo -e "${YC}Install Java${NC}"
dnf install -y java-21-openjdk-devel &>>$OUTPUT
status_check

echo -e "${YC}Download and Extract Application${NC}"
app_prereq
status_check

echo -e "${YC}Build Application${NC}"
cd /app
chmod +x gradlew &>>$OUTPUT
./gradlew bootJar --no-daemon -x test &>>$OUTPUT
status_check

echo -e "${YC}Copy Jar File${NC}"
cp /app/build/libs/*.jar /app/${service_name}.jar &>>$OUTPUT
status_check

set_permissions

echo -e "${YC}Copy Service File${NC}"
echo "Service name: ${service_name}"
echo "PWD: $(pwd)"
cp ${service_name}.service /etc/systemd/system/${service_name}.service &>>$OUTPUT
status_check

start_service