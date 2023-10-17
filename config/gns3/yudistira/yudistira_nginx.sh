echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     arjuna.e27.com. root.arjuna.e27.com. (
                        2023101001      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      arjuna.e27.com.
@       IN      A       10.50.3.3     ; IP Arjuna
www     IN      CNAME   arjuna.e27.com.' > /etc/bind/jarkom/arjuna.e27.com

service bind9 restart
