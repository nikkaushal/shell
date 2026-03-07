dnf module disable nginx -y
dnf module enable nginx:1.26 -y
dnf install -y nginx

cp nginx.conf /etc/nginx/nginx.conf

systemctl enable nginx
systemctl start nginx

curl -fsSL https://rpm.nodesource.com/setup_22.x | bash -
dnf install -y nodejs

node --version
npm --version

curl -L -o /tmp/frontend.tar.gz https://raw.githubusercontent.com/raghudevopsb88/wealth-project/main/artifacts/frontend.tar.gz
mkdir -p /tmp/frontend
cd /tmp/frontend
tar xzf /tmp/frontend.tar.gz

cd /tmp/frontend
npm ci
npm run build

systemctl restart nginx
