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

# Soal 7
Seperti yang kita tahu karena banyak sekali informasi yang harus diterima, buatlah subdomain khusus untuk perang yaitu baratayuda.abimanyu.yyy.com dengan alias www.baratayuda.abimanyu.yyy.com yang didelegasikan dari Yudhistira ke Werkudara dengan IP menuju ke Abimanyu dalam folder Baratayuda.

# Soal 8
Untuk informasi yang lebih spesifik mengenai Ranjapan Baratayuda, buatlah subdomain melalui Werkudara dengan akses rjp.baratayuda.abimanyu.yyy.com dengan alias www.rjp.baratayuda.abimanyu.yyy.com yang mengarah ke Abimanyu.
