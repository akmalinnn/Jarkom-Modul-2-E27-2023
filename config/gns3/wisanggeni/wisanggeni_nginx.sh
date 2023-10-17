mkdir /var/www/jarkom

echo "<?php
\$hostname = gethostname();
\$php_version = phpversion();

echo \"Hello World!<br>\";
echo \"Saat ini berada di: \$hostname<br>\";
echo \"Versi PHP yang saya gunakan: \$php_version<br>\";
?>" > /var/www/jarkom/index.php


service php7.0-fpm start

echo 'server {
        listen 8003;

        root /var/www/jarkom;
        index index.php index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                try_files $uri $uri/ /index.php?$query_string;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/run/php/php7.0-fpm.sock;
        }

        location ~ /\.ht {
                deny all;
        }
}' > /etc/nginx/sites-available/jarkom

ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled/jarkom

rm /etc/nginx/sites-enabled/default

service nginx restart
