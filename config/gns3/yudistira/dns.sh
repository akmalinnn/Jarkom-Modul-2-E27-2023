echo 'zone "arjuna.e27.com" {
        type master;
        file "/etc/bind/jarkom/arjuna.e27.com";
        allow-transfer { 10.50.3.3; }; // IP Arjuna
};

zone "abimanyu.e27.com" {
        type master;
        file "/etc/bind/jarkom/abimanyu.e27.com";
        allow-transfer { 10.50.3.4; }; // IP Arjuna
};' > /etc/bind/named.conf.local

cp /etc/bind/db.local /etc/bind/jarkom/abimanyu.e27.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.e27.com. root.abimanyu.e27.com. (
                        2023101001      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      abimanyu.e27.com.
@       IN      A       10.50.2.2    ; IP Yudhistira
www     IN      CNAME   abimanyu.e27.com.' > /etc/bind/jarkom/abimanyu.e27.com

service bind9 restart
