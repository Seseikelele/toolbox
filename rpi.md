# Raspberry Pi

## Hostname
```
echo "malina" > /etc/hostname
```

do podmiany również w `/etc/hosts`

## MotD
```
sudo vim /etc/motd
```

## Zmiana użytkownika
```bash
sudo useradd -m seseikelele
sudo passwd seseikelele

#should add excluding pi group
for group in $(groups)
do
        sudo adduser seseikelele $group
done
sudo deluser seseikelele pi
sudo deluser --group pi

sudo deluser -r -f pi
```

## Montowanie USB
`sudo vim /etc/fstab`
```
/dev/sda1 /media/usb1 auto defaults,noatime 0 2
/dev/sdb1 /media/usb2 auto defaults,noatime 0 2
```

## Mailer codziennie o 10
`crontab -e`
```
0 10 * * * /home/seseikelele/dev/mailer/mailer.py >> /home/seseikelele/dev/mailer/log
```

## apt update && apt dist upgrade
`sudo crontab -e`
```
0 3 * * * apt update >> /var/log/apt/cron-update.log
5 3 * * * apt dist-upgrade >> /var/log/apt/cron-update.log
```

## Dyndns
[Creating a systemd service](https://medium.com/@benmorel/creating-a-linux-service-with-systemd-611b5c8b91d6)

## SSH
`sudo vim /etc/ssh/sshd_config`

```
Port xx
AllowUsers dev
TCPKeepAlive yes
ClientAliveInterval 60
ClientAliveCountMax 3
PasswordAuthentication no (dopiero po ustawieniu klucza ssh)
```

`sudo systemctl restart ssh`

### SSH VIA KEY
```
ssh-keygen
ssh-copy-id user@192.168.x.y
```

## UFW
```
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow http
sudo ufw allow https
sudo ufw limit ssh/tcp
#deny multicast from router
sudo ufw deny from 192.168.178.1 to 224.0.0.1
sudo ufw enable
sudo ufw status
```

## Apache2
### Debian, Ubuntu (Apache httpd 2.x):
wszystko ładnie pięknie z dokumentacją z pakietu `apache2-doc`
```
ServerRoot              ::      /etc/apache2
DocumentRoot            ::      /var/www
Apache Config Files     ::      /etc/apache2/apache2.conf
                        ::      /etc/apache2/ports.conf
Default VHost Config    ::      /etc/apache2/sites-available/default, /etc/apache2/sites-enabled/000-default
Module Locations        ::      /etc/apache2/mods-available, /etc/apache2/mods-enabled
ErrorLog                ::      /var/log/apache2/error.log
AccessLog               ::      /var/log/apache2/access.log
cgi-bin                 ::      /usr/lib/cgi-bin
binaries (apachectl)    ::      /usr/sbin
start/stop              ::      /etc/init.d/apache2 (start|stop|restart|reload|force-reload|start-htcacheclean|stop-htcacheclean)
```
### HTTPS
ln -s ../mods-available/ssl.conf
ln -s ../mods-available/ssl.load
ln -s ../mods-available/socache_shmcb.load
[Enable SSLEngine](https://httpd.apache.org/docs/2.4/ssl/ssl_howto.html)

#### lets encrypt
[CertBot](https://certbot.eff.org/lets-encrypt/debianbuster-apache)

`sudo apt-get install certbot python-certbot-apache`

## WWW REDIRECTS
### VirtualHost Redirects
[404 for unknown ServerName](https://serverfault.com/questions/231438/how-do-i-configure-the-default-virtual-host-return-a-404-header-in-apache)
### 301
```
RewriteEngine On
RewriteCond %{HTTP_HOST} ^(www\.)?domena_źródłowa\.pl [NC]
RewriteRule (.*) http://domena_docelowa.pl/$1 [R=301,L]
```

### Wymuszenie HTTPS
```
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule .* https://%{HTTP_HOST}%{REQUEST_URI}
```

### Wymuszenie www.
```
RewriteEngine On
RewriteCond %{HTTP_HOST} !^$
RewriteCond %{HTTP_HOST} !^www\. [NC]
RewriteCond %{HTTPS}s ^on(s)|
RewriteRule ^ http%1://www.%{HTTP_HOST}%{REQUEST_URI} [R=301,L]
```

### Wymuszenie braku www.
```
RewriteEngine on
RewriteCond %{HTTP_HOST} ^www\.
RewriteCond %{HTTPS}s ^on(s)|off
RewriteCond http%1://%{HTTP_HOST} ^(https?://)(www\.)?(.+)$
RewriteRule ^ %1%3%{REQUEST_URI} [R=301,L]
```

## OctoPrint
[Webpage/Download](https://octoprint.org/download/)

`sudo apt-get install python3 python3-pip virtualenv`
