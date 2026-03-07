dnf install -y golang

useradd -r -s /bin/false appuser
mkdir -p /app

cp auth-service.service /etc/systemd/system/auth-service.service

curl -L -o /tmp/auth-service.tar.gz https://raw.githubusercontent.com/raghudevopsb88/wealth-project/main/artifacts/auth-service.tar.gz
cd /app
tar xzf /tmp/auth-service.tar.gz

cd /app
CGO_ENABLED=0 go build -o auth-service ./cmd/server

chown -R appuser:appuser /app
chmod o-rwx /app -R


systemctl daemon-reload
systemctl enable auth-service
systemctl start auth-service