

echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.e27
  ServerName parikesit.abimanyu.e27.com
  ServerAlias www.parikesit.abimanyu.e27.com

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.e27.com.conf

a2ensite parikesit.abimanyu.e27.com.conf

service apache2 restart
