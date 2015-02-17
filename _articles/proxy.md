---
title: "How to expose the app to the world"
categories:
  - tips
---

Since your app will start under a non-privileged user, you can't just `config:set PORT=80`. Therefore, if you want to expose your application to the world on port 80 or 443, you can either use Apache or Nginx to proxy the incoming requests on port 80 to the port on which your app listens:

## Apache (debian)

``` command-line
# install apache
sudo apt-get install -y apache2
```

``` command-line
# enabled required modules
sudo a2enmod proxy_http
# setup apache configuration
cat > /etc/apache2/sites-available/default <<EOF
<VirtualHost *:80>
  ServerName example.com
  <Location />
    ProxyPass http://localhost:6000/
  </Location>
</VirtualHost>
EOF
# restart apache
sudo service apache2 restart
```

## Nginx (debian)

``` command-line
# install nginx
sudo apt-get install -y nginx
```

``` command-line
# setup nginx configuration
cat > /etc/nginx/sites-available/default <<EOF
server {
  listen          80;
  server_name     example.com;
  location / {
    proxy_pass      http://localhost:6000;
  }
}
EOF
# restart nginx
sudo service nginx restart
```


## iptables

You can also quickly achieve the same result by adding a few `iptable` rules, such as:

    iptables -A PREROUTING -t nat -p tcp --dport 80 -j REDIRECT --to-port 6000
    iptables -t nat -I OUTPUT -p tcp -d 127.0.0.1 --dport 80 -j REDIRECT --to-ports 6000

Note that iptable rules will not survive a reboot, so the Apache or Nginx approach is recommended.
