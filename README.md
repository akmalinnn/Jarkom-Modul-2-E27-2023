# Praktikum Modul 2 Jaringan Komputer

# Anggota Kelompok E27 :
| No.  | Nama Anggota       | NRP          |
|------|--------------------|--------------|
| 1    |Rachman Ridwan           | 5025201061   |
| 2    | Akmal Nafis         | 5025211216   |

# Topologi
![image](https://cdn.discordapp.com/attachments/945203039034306570/1163727683763576873/02.png?ex=6540a0dc&is=652e2bdc&hm=2bef5fe131cf7a96ff68fc5531b2bd4ebb9cf54122e0e6a6bbe41edc71b61af8&)

# konfigurasi network

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

## inisiasi ./bashrc

- **Router**
```

```

## Soal 1

## Soal 2
## Soal 3
## Soal 4
## Soal 5
## Soal 6
## Soal 7
## Soal 8
## Soal 9
## Soal 10
## Soal 11
## Soal 12
## Soal 13
## Soal 14
## Soal 15
## Soal 16
## Soal 17
## Soal 18
## Soal 19
## Soal 20

