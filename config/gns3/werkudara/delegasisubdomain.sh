echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     baratayuda.abimanyu.e27.com. root.baratayuda.abimanyu.e27.com. (
                        2023101001      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@               IN      NS      baratayuda.abimanyu.e27.com.
@               IN      A       10.50.3.4     ; IP Abimanyu
www             IN      CNAME   baratayuda.abimanyu.e27.com.
rjp             IN      A       10.50.3.4     ; IP Abimanyu
www.rjp         IN      CNAME   rjp.baratayuda.abimanyu.e27.com.' > /etc/bind/baratayuda/baratayuda.abimanyu.e27.com

service bind9 restart

