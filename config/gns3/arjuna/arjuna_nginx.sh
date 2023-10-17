echo 'upstream backend {
  server 10.50.3.5:8001; # IP PrabuKusuma
  server 10.50.3.4:8002; # IP Abimanyu
  server 10.50.3.6:8003; # IP Wisanggeni
}

server {
  listen 80;
  server_name arjuna.e27.com www.arjuna.e27.com;

  location / {
    proxy_pass http://backend;
  }
}
' > /etc/nginx/sites-available/jarkom

ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled/jarkom

rm /etc/nginx/sites-enabled/default

service nginx restart
