echo ';
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
@       IN      A       10.50.3.4     ; IP Abimanyu
www     IN      CNAME   abimanyu.e27.com.
parikesit IN    A       10.50.3.4     ; IP Abimanyu
ns1     IN      A       10.50.3.2     ; IP Werkudara
baratayuda IN   NS      ns1' > /etc/bind/jarkom/abimanyu.e27.com

service bind9 restart
