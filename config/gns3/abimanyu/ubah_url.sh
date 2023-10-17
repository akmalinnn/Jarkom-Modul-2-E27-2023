echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/abimanyu.e27
  ServerName abimanyu.e27.com
  ServerAlias www.abimanyu.e27.com

  <Directory /var/www/abimanyu.e27/index.php/home>
          Options +Indexes
  </Directory>

  Alias "/home" "/var/www/abimanyu.e27/index.php/home"

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/abimanyu.e27.com.conf

service apache2 restart
