echo 'zone "arjuna.e27.com" {
        type master;
        file "/etc/bind/jarkom/arjuna.e27.com";
        allow-transfer { 10.50.3.2; }; // IP Werkudara
};

zone "abimanyu.e27.com" {
        type master;
        notify yes;
        also-notify { 10.50.3.2; }; // IP Werkudara
        allow-transfer { 10.50.3.2; }; // IP Werkudara
        file "/etc/bind/jarkom/abimanyu.e27.com";
};

zone "3.50.10.in-addr.arpa" {
        type master;
        file "/etc/bind/jarkom/3.50.10.in-addr.arpa";
};' > /etc/bind/named.conf.local

service bind9 restart
