

echo 'zone "abimanyu.e27.com" {
    type slave;
    masters { 10.50.2.2; }; // Masukan IP Yudhistira
    file "/var/lib/bind/abimanyu.e27.com";
};' > /etc/bind/named.conf.local

service bind9 restart
