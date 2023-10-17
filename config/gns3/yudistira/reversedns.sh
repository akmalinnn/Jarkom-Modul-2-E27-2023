echo 'zone "arjuna.e27.com" {
        type master;
        file "/etc/bind/jarkom/arjuna.e27.com";
        allow-transfer { 10.50.3.3; }; // IP Arjuna
};

zone "abimanyu.e27.com" {
        type master;
        file "/etc/bind/jarkom/abimanyu.e27.com";
        allow-transfer { 10.50.3.4; }; // IP Arjuna
};

zone "3.50.10.in-addr.arpa" {
        type master;
        file "/etc/bind/jarkom/3.50.10.in-addr.arpa";
};' > /etc/bind/named.conf.local

cp /etc/bind/db.local /etc/bind/jarkom/3.50.10.in-addr.arpa

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.e27.com. root.abimanyu.e27.com. (
                        2003101001      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
3.50.10.in-addr.arpa. IN      NS      abimanyu.e27.com.
3                       IN      PTR     abimanyu.e27.com.
5                       IN      PTR     arjuna.e27.com.' > /etc/bind/jarkom/3.50.10.in-addr.arpa

service bind9 restart
