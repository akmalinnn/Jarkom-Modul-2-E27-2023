# Praktikum Modul 2 Jaringan Komputer

# Anggota Kelompok E27 :
| No.  | Nama Anggota       | NRP          |
|------|--------------------|--------------|
| 1    |Rachman Ridwan           | 5025201061   |
| 2    | Akmal Nafis         | 5025211216   |

# Topologi
![image](https://cdn.discordapp.com/attachments/945203039034306570/1163727683763576873/02.png?ex=6540a0dc&is=652e2bdc&hm=2bef5fe131cf7a96ff68fc5531b2bd4ebb9cf54122e0e6a6bbe41edc71b61af8&)

![image](https://cdn.discordapp.com/attachments/945203039034306570/1163742346760953896/image.png?ex=6540ae84&is=652e3984&hm=7538bcfe04aa6cf01165c183e401d4a7fe612dc043533c26f140977837754bf0&)

# Konfigurasi network

- **Pandudewanata**
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 10.50.1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 10.50.2.1
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 10.50.3.1
	netmask 255.255.255.0
```
-  **Sadewa**
```
auto eth0
iface eth0 inet static
	address 10.50.1.2
	netmask 255.255.255.0
	gateway 10.50.1.1
  ```

- **Nakula**
 ```
auto eth0
iface eth0 inet static
	address 10.50.1.3
	netmask 255.255.255.0
	gateway 10.50.1.1
  ```

- **Yudhistira**
```
auto eth0
iface eth0 inet static
	address 10.50.2.2
	netmask 255.255.255.0
	gateway 10.50.2.1
```

- **Werkudara**
```
auto eth0
iface eth0 inet static
	address 10.50.3.2
	netmask 255.255.255.0
	gateway 10.50.3.1
```
- **Arjuna**
```
auto eth0
iface eth0 inet static
	address 10.50.3.3
	netmask 255.255.255.0
	gateway 10.50.3.1
```
- **Abimanyu**
```
auto eth0
iface eth0 inet static
	address 10.50.3.4
	netmask 255.255.255.0
	gateway 10.50.3.1
```

- **Prabukusuma**
```
auto eth0
iface eth0 inet static
	address 10.50.3.5
	netmask 255.255.255.0
	gateway 10.50.3.1
```

- **Wisanggeni**
```
auto eth0
iface eth0 inet static
	address 10.50.3.6
	netmask 255.255.255.0
	gateway 10.50.3.1
```

## Inisiasi ./bashrc

- **Router**
```
apt-get update
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.50.1.1
/16
echo nameserver 192.168.122.1 > /etc/resolv.conf
```
- **DNS master, DNS slave**
```
echo 'nameserver 192.168.122.1' > /etc/resolv.conf
apt-get update
apt-get install bind9 -y
```

Prefix IP Kelompok E27 : 10.50.x.x

# Soal 1
Yudhistira akan digunakan sebagai DNS Master, Werkudara sebagai DNS Slave, Arjuna merupakan Load Balancer yang terdiri dari beberapa Web Server yaitu Prabakusuma, Abimanyu, dan Wisanggeni.

Topologi :
![image](https://cdn.discordapp.com/attachments/945203039034306570/1163742346760953896/image.png?ex=6540ae84&is=652e3984&hm=7538bcfe04aa6cf01165c183e401d4a7fe612dc043533c26f140977837754bf0&)

(Konfigurasi terdapat pada halaman di atas)

# Soal 2
Buatlah website utama dengan akses ke arjuna.yyy.com dengan alias www.arjuna.yyy.com dengan yyy merupakan kode kelompok.

Penyelesaian :
1. Install bind9 pada node Yudhistira
   ```
	apt-get update
   	apt-get install bind9 -y
   ```

2. Daftarkan domain pada node Yudhistira di directory /etc/bind/named.conf.local
   ```
	zone "arjuna.e27.com" {
        type master;
        file "/etc/bind/jarkom/arjuna.e27.com";
	};
   ```

3. Konfigurasi file pada directory berikut /etc/bind/jarkom/arjuna.e27.com
   ```
	;
	; BIND data file for local loopback interface
	;
	$TTL    604800
	@       IN      SOA     arjuna.e27.com. root.arjuna.e27.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
	;
	@       IN      NS      arjuna.e27.com.
	@       IN      A       10.50.2.2 ; IP arjuna
	www     IN      CNAME   arjuna.e27.com.
	@       IN      AAAA    ::1
   ```

4. Masukkan IP DNS pada nameserver node client (Nakula)
   ```
	echo nameserver 192.168.122.1 > /etc/resolv.conf
   ```

Untuk melakukan pengecekan apakah berhasil atau tidak, Lakukan ping menuju arjuna.e27.com pada node client.

# Soal 3
Dengan cara yang sama seperti soal nomor 2, buatlah website utama dengan akses ke abimanyu.yyy.com dan alias www.abimanyu.yyy.com.

1. Sama halnya seperti soal nomor 2, Tambahkan konfigurasi berikut pada file /etc/bind/named.conf.local pada node Yudhistira
   ```
	zone "arjuna.e27.com" {
        type master;
        file "/etc/bind/jarkom/arjuna.e27.com";
	};

	zone "abimanyu.e27.com" {
        type master;
        file "/etc/bind/jarkom/abimanyu.e27.com";
	};

   ```
2. Konfigurasi pada /etc/bind/jarkom/abimanyu.e27.com
   ```
	;
	; BIND data file for local loopback interface
	;
	$TTL    604800
	@       IN      SOA     abimanyu.e27.com. root.abimanyu.e27.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
	;
	@       IN      NS      abimanyu.e27.com.
	@       IN      A       10.50.2.4 ; IP Abimanyu
	www     IN      CNAME   abimanyu.e27.com.
	@       IN      AAAA    ::1


   ```

3. Restart bind9
   ```
	service bind9 restart
   ```

Untuk melakukan pengecekan apakah berhasil atau tidak, Lakukan ping menuju arjuna.e27.com atau abimanyu.e27.com pada node client.

# Soal 4
Kemudian, karena terdapat beberapa web yang harus di-deploy, buatlah subdomain parikesit.abimanyu.yyy.com yang diatur DNS-nya di Yudhistira dan mengarah ke Abimanyu.

Penyelesaian :

1. Konfigurasi file /etc/bind/jarkom/abimanyu.e27.com pada node Yudhistira
   ```
	;
	; BIND data file for local loopback interface
	;
	$TTL    604800
	@       IN      SOA     abimanyu.e27.com. root.abimanyu.e27.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
	;
	@       	IN      NS      abimanyu.e27.com.
	@       	IN      A       10.50.2.4 ; IP Abimanyu
	www     	IN      CNAME   abimanyu.e27.com.
   	parikesit	IN	A	10.50.2.4
   	www.parikesit	IN	CNAME	parikesit.abimanyu.e27.com
	@       	IN      AAAA    ::1
   ```

Untuk melakukan pengecekan apakah berhasil atau tidak, Lakukan ping menuju parikesit.abimanyu.e27.com atau www.parikesit.abimanyu.e27.com pada node client.

# Soal 5
Buat juga reverse domain untuk domain utama.

Penyelesaian :
1. Tambahkan konfigurasi zone reverse di /etc/bind/named.conf.local pada node Yudhistira
   ```
	zone "arjuna.e27.com" {
        type master;
        file "/etc/bind/jarkom/arjuna.e27.com";
	};

	zone "abimanyu.e27.com" {
        type master;
        file "/etc/bind/jarkom/abimanyu.e27.com";
	};

   	zone "2.50.10.in-addr.arpa" {
    	type master;
    	file "/etc/bind/jarkom/2.50.10.in-addr.arpa";
	};
   ```

2. Konfigurasi pada file /etc/bind/jarkom/2.50.10.in-addr.arpa
   ```
	;
	; BIND data file for local loopback interface
	;
	$TTL    604800
	@       IN      SOA     arjuna.e27.com. root.arjuna.e27.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
	;
	2.50.10.in-addr.arpa.   	IN      NS      arjuna.e27.com.
	4                         	IN      PTR     arjuna.e27.com.

   ```

   (Untuk reverse domain abimanyu lakukan hal yang sama seperti pada domain reverse arjuna)

3. Install DNS Utils pada node client untuk melakukan pengecekan
   ```
	echo nameserver 192.168.122.1 > /etc/resolv.conf

	apt-get update
	apt-get install dnsutils

	echo nameserver 10.50.3.2 > /etc/resolv.conf

   ```

4. Gunakan command host untuk mengecek keberhasilan reverse
   ```
	host -t PTR 10.50.2.3
   ```
   ```
	host -t PTR 10.50.2.4
   ```

# Soal 6
Agar dapat tetap dihubungi ketika DNS Server Yudhistira bermasalah, buat juga Werkudara sebagai DNS Slave untuk domain utama.

Penyelesaian :
1. Tambahkan konfigurasi /etc/bind/named.conf.local
```
	zone "arjuna.e27.com" {
        type master;
	notify yes;
        also-notify { 10.50.3.2; }; // IP Werkudara
        allow-transfer { 10.50.3.2; }; // IP Werkudara
        file "/etc/bind/jarkom/arjuna.e27.com";
	};

	zone "abimanyu.e27.com" {
        type master;
	notify yes;
        also-notify { 10.50.3.2; }; // IP Werkudara
        allow-transfer { 10.50.3.2; }; // IP Werkudara
        file "/etc/bind/jarkom/abimanyu.e27.com";
	};

   	zone "2.50.10.in-addr.arpa" {
    	type master;
    	file "/etc/bind/jarkom/2.50.10.in-addr.arpa";
	};
```

2. Install bind9 pada DNS Slave
   ```
   apt-get update
   apt-get install bind9
   ```

3. Konfigurasi
   ```
	zone "arjuna.e27.com" {
    	type slave;
    	masters { 10.50.2.2; }; // IP Yudhistira
    	file "/var/lib/bind/arjuna.e27.com";
	};

	zone "abimanyu.e27.com" {
    	type slave;
    	masters { 10.50.2.2; }; // IP Yudhistira
    	file "/var/lib/bind/abimanyu.e27.com";
	};

   ```

4. Restart bind9
   ```
   service bind9 restart
   ```

5. Hentikan service bind9 pada DNS Master
   ```
   service bind9 stop
   ```

Lakukan ping arjuna.e27.com dan abimanyu.e27.com pada client dengan nameserver IP werkudara.

# Soal 7
Seperti yang kita tahu karena banyak sekali informasi yang harus diterima, buatlah subdomain khusus untuk perang yaitu baratayuda.abimanyu.yyy.com dengan alias www.baratayuda.abimanyu.yyy.com yang didelegasikan dari Yudhistira ke Werkudara dengan IP menuju ke Abimanyu dalam folder Baratayuda.

Penyelesaian :
1. Konfigurasi /etc/bind/jarkom/abimanyu.e27.com pada DNS Master
```
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.e27.com. root.abimanyu.e27.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@              IN      NS      abimanyu.e27.com.
@              IN      A       10.50.3.4
www            IN      CNAME   abimanyu.e27.com.
parikesit      IN      A       10.50.3.4
www.parikesit  IN      CNAME   parikesit.abimanyu.e27.com.
baratayuda     IN      NS      ns1.abimanyu.e27.com.
ns1            IN      A       10.50.3.2      ; IP Werkudara
@       IN      AAAA    ::1

```

2. Konfigurasi /etc/bind/named.conf.options pada node DNS Master.
```
options {
        directory "/var/cache/bind";
        allow-query{any;};

        listen-on-v6 { any; };
};
```

3. Restart bind9
```
service bind9 restart
```

4. Konfigurasi /etc/bind/named.conf.local pada DNS Slave.
```
zone "arjuna.e27.com" {
    	type slave;
    	masters { 10.50.2.2; }; // IP Yudhistira
    	file "/var/lib/bind/arjuna.e27.com";
	};

	zone "abimanyu.e27.com" {
    	type slave;
    	masters { 10.50.2.2; }; // IP Yudhistira
    	file "/var/lib/bind/abimanyu.e27.com";
	};

	zone "baratayuda.abimanyu.e27.com" {
    	type master;
 	file "/etc/bind/baratayuda/baratayuda.abimanyu.e27.com";
};

```

5. Konfigurasi /etc/bind/baratayuda/baratayuda.abimanyu.e27.com
```
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     baratayuda.abimanyu.e27.com. root.baratayuda.abimanyu.e27.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@                       IN      NS      baratayuda.abimanyu.e27.com.
@                       IN      A       10.50.3.4 ; IP Abimanyu
www                     IN      CNAME   baratayuda.abimanyu.e27.com.
@                       IN      AAAA    ::1

```

6. Konfigurasi /etc/bind/named.conf.options pada node DNS Slave.
```
options {
        directory "/var/cache/bind";

        allow-query{any;};

        listen-on-v6 { any; };
};

```

7. Restart bind9
```
service bind9 restart
```

8. Stop bind9
```
service bind9 stop
```

Lakukan ping ke baratayuda.abimanyu.e27.com dan www.baratayuda.abimanyu.e27.com

# Soal 8
Untuk informasi yang lebih spesifik mengenai Ranjapan Baratayuda, buatlah subdomain melalui Werkudara dengan akses rjp.baratayuda.abimanyu.yyy.com dengan alias www.rjp.baratayuda.abimanyu.yyy.com yang mengarah ke Abimanyu.

Penyelesaian :
1. Tambahkan konfigurasi berikut pada file /etc/bind/named.conf.local pada node DNS Slave.

```
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     baratayuda.abimanyu.e27.com. root.baratayuda.abimanyu.e27.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@                       IN      NS      baratayuda.abimanyu.a07.com.
@                       IN      A       10.50.3.4 ; IP Abimanyu
www                     IN      CNAME   baratayuda.abimanyu.a07.com.
rjp                     IN      A       10.50.3.4 ; IP Abimanyu
www.rjp                 IN      CNAME   rjp.baratayuda.abimanyu.e27.com.
@                       IN      AAAA    ::1


```

2. Lakukan restart bind9 pada DNS Slave.

```
service bind9 restart
```
# Soal 9
Arjuna merupakan suatu Load Balancer Nginx dengan tiga worker yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Lakukan deployment pada masing-masing worker.

Penyelesaian :
## Soal 9

> (Arjuna merupakan suatu Load Balancer Nginx dengan tiga worker yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Lakukan deployment pada masing-masing worker.)

### Scripts

1. Jalankan command berikut pada node Prabukusuma.

```
echo nameserver 192.168.122.1 > /etc/resolv.conf


apt-get update && apt install nginx php php-fpm -y


# Buat folder jarkom
mkdir /var/www/jarkom


# echo ke file /var/www/jarkom/index.php
echo '<?php
echo "Hello World from prabukusuma";
?>' > /var/www/jarkom/index.php


echo '
 server {


        listen 8001;


        root /var/www/jarkom;


        index index.php index.html index.htm;
        server_name _;


        location / {
                        try_files $uri $uri/ /index.php?$query_string;
        }


        # pass PHP scripts to FastCGI server
        location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        }


 location ~ /\.ht {
                        deny all;
        }


        error_log /var/log/nginx/jarkom_error.log;
        access_log /var/log/nginx/jarkom_access.log;
 }
' > /etc/nginx/sites-available/jarkom


ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled/jarkom


rm /etc/nginx/sites-enabled/default




service nginx restart
service php7.0-fpm stop
service php7.0-fpm start

```

2. Jalankan command berikut pada node Abimanyu.

```
echo nameserver 192.168.122.1 > /etc/resolv.conf


apt-get update && apt install nginx php php-fpm -y


# Buat folder jarkom
mkdir /var/www/jarkom


# echo ke file /var/www/jarkom/index.php
echo '<?php
echo "Hello World from abimanyu";
?>' > /var/www/jarkom/index.php




echo '
 server {


  listen 8002;


  root /var/www/jarkom;


  index index.php index.html index.htm;
  server_name _;


  location / {
      try_files $uri $uri/ /index.php?$query_string;
  }


  # pass PHP scripts to FastCGI server
  location ~ \.php$ {
  include snippets/fastcgi-php.conf;
  fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
  }


    location ~ /\.ht {
      deny all;
  }


  error_log /var/log/nginx/jarkom_error.log;
  access_log /var/log/nginx/jarkom_access.log;
 }
' > /etc/nginx/sites-available/jarkom




ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled/jarkom
rm /etc/nginx/sites-enabled/default


service nginx restart
service php7.0-fpm stop
service php7.0-fpm start

```

3. Jalankan command berikut pada node Wisanggeni.

```
echo nameserver 192.168.122.1 > /etc/resolv.conf


apt-get update && apt install nginx php php-fpm -y


# Buat folder jarkom
mkdir /var/www/jarkom


# echo ke file /var/www/jarkom/index.php
echo '<?php
echo "Hello World from wisanggeni";
?>' > /var/www/jarkom/index.php


echo '
 server {


        listen 8003;


        root /var/www/jarkom;


        index index.php index.html index.htm;
        server_name _;


        location / {
                        try_files $uri $uri/ /index.php?$query_string;
        }


        # pass PHP scripts to FastCGI server
        location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        }


 location ~ /\.ht {
                        deny all;
        }


        error_log /var/log/nginx/jarkom_error.log;
        access_log /var/log/nginx/jarkom_access.log;
 }
' > /etc/nginx/sites-available/jarkom


ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled/jarkom


rm /etc/nginx/sites-enabled/default




service nginx restart
service php7.0-fpm stop
service php7.0-fpm start

```

4. Jalankan command berikut pada node Load Balancer.

```
echo nameserver 192.168.122.1 > /etc/resolv.conf


apt-get update


# Install bind9
apt-get install bind9 nginx -y


echo ' # Default menggunakan Round Robin
 upstream myweb  {
  server 10.50.3.5 #IP Prabukusuma
  server 10.50.3.4 #IP Abimanyu
  server 10.50.3.6 #IP Wisanggeni
 }


 server {
  listen 80;
  server_name arjuna.e27.com www.arjuna.e27.com;


  location / {
  proxy_pass http://myweb;
  }
 }' > /etc/nginx/sites-available/lb-jarkom


ln -s /etc/nginx/sites-available/lb-jarkom /etc/nginx/sites-enabled/lb-jarkom




service nginx restart

```

## Soal 10

1. Ubah konfigurasi file `/etc/nginx/sites-available/jarkom` pada node Prabukusuma.

```
echo '
 server {


        listen 8002;


        root /var/www/jarkom;


        index index.php index.html index.htm;
        server_name _;


        location / {
                        try_files $uri $uri/ /index.php?$query_string;
        }


        # pass PHP scripts to FastCGI server
        location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        }


 location ~ /\.ht {
                        deny all;
        }


        error_log /var/log/nginx/jarkom_error.log;
        access_log /var/log/nginx/jarkom_access.log;
 }
' > /etc/nginx/sites-available/jarkom

```

2. Ubah konfigurasi file `/etc/nginx/sites-available/jarkom` pada node Abimanyu.

```
echo '
 server {


  listen 8001;


  root /var/www/jarkom;


  index index.php index.html index.htm;
  server_name _;


  location / {
      try_files $uri $uri/ /index.php?$query_string;
  }


  # pass PHP scripts to FastCGI server
  location ~ \.php$ {
  include snippets/fastcgi-php.conf;
  fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
  }


    location ~ /\.ht {
      deny all;
  }


  error_log /var/log/nginx/jarkom_error.log;
  access_log /var/log/nginx/jarkom_access.log;
 }
' > /etc/nginx/sites-available/jarkom
```

3. Ubah konfigurasi file `/etc/nginx/sites-available/jarkom` pada node Wisanggeni.

```
echo '
 server {


        listen 8003;


        root /var/www/jarkom;


        index index.php index.html index.htm;
        server_name _;


        location / {
                        try_files $uri $uri/ /index.php?$query_string;
        }


        # pass PHP scripts to FastCGI server
        location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        }


 location ~ /\.ht {
                        deny all;
        }


        error_log /var/log/nginx/jarkom_error.log;
        access_log /var/log/nginx/jarkom_access.log;
 }
' > /etc/nginx/sites-available/jarkom

```

4. Jalankan command berikut pada node Load Balancer.

```
echo nameserver 192.168.122.1 > /etc/resolv.conf


apt-get update


# Install bind9
apt-get install bind9 nginx -y


echo ' # Default menggunakan Round Robin
 upstream myweb  {
  server 10.50.3.5:8001; #IP Prabukusuma
  server 10.50.3.4:8002; #IP Abimanyu
  server 10.50.3.6:8003; #IP Wisanggeni
 }


 server {
  listen 80;
  server_name arjuna.e27.com www.arjuna.e27.com;


  location / {
  proxy_pass http://myweb;
  }
 }' > /etc/nginx/sites-available/lb-jarkom


ln -s /etc/nginx/sites-available/lb-jarkom /etc/nginx/sites-enabled/lb-jarkom




service nginx restart


```

### Bukti

1. lakukan `lynx arjuna.e27.com`.


## Soal 11

