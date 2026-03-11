app_prereq() {
  id appuser &>/dev/null
  if [ $? -ne 0 ]; then
    useradd -r -s /bin/false appuser
  fi
  mkdir -p /app
  curl -L -o /tmp/${service_name}.tar.gz https://raw.githubusercontent.com/raghudevopsb88/wealth-project/main/artifacts/${service_name}.tar.gz
  cd /app
  tar xzf /tmp/${service_name}.tar.gz
}

YC="\e[33m"
RC="\e[31m"
GC="\e[32m"
NC="\e[0m"
OUTPUT=/tmp/wmp.log
rm -f $OUTPUT

status_check() {
  if [ $? -eq 0 ]; then
    echo -e "${GC}SUCCESS${NC}"
  else
    echo -e "${RC}FAILURE${NC}"
  fi
}
