### 1. Install the Packages from the Ubuntu Repositories

If you are using Python 2, type:

```bash
sudo apt-get update
sudo apt-get install python-pip python-dev mysql-server mysql-client nginx
```

If you are using Django with Python 3, type:

```bash
sudo apt-get update
sudo apt-get install python3-pip python3-dev mysql-server mysql-client nginx
```

### 2: Configure MySQL

```bash
mysql -u root -p
CREATE DATABASE testdb;
CREATE USER 'test'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON testdb.* TO 'test'@'localhost';
```

### 3. Create a Python Virtual Environment for your Project

If you are using Python 2, upgrade pip and install the package by typing:

```bash
sudo -H pip install --upgrade pip
sudo -H pip install virtualenv
```

If you are using Python 3, upgrade pip and install the package by typing:

```bash
sudo -H pip3 install --upgrade pip
sudo -H pip3 install virtualenv
```

```bash
mkdir ~/myproject
cd ~/myproject
virtualenv env
source env/bin/activate
pip install django gunicorn mysql-python
```

### 3. Clone Django Project

```bash
cd ~/myproject
git clone git-url src
```

### 4. Config Django Project
Edit the `settings.py` file:

```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'testdb',
        'USER': 'test',
        'PASSWORD': 'password',
        'HOST': '127.0.0.1',
        'PORT': '',
    }
}

STATIC_ROOT = os.path.join(BASE_DIR, 'static/')
```

```bash
~/myproject/src/manage.py makemigrations
~/myproject/src/manage.py migrate
~/myproject/src/manage.py createsuperuser
~/myproject/src/manage.py collectstatic
```

### 5. Create a Gunicorn systemd Service File

`sudo nano /etc/systemd/system/gunicorn.service`

```bash
[Unit]
Description=gunicorn daemon
After=network.target

[Service]
User=hoso
Group=www-data
WorkingDirectory=/home/user/myproject/src
ExecStart=/home/user/myproject/env/bin/gunicorn --access-logfile - --workers 3 --bind unix:/home/user/myproject/src/myproject.sock myproject.wsgi:application

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl start gunicorn
sudo systemctl enable gunicorn
```

### 6. Configure Nginx to Proxy Pass to Gunicorn

`sudo nano /etc/nginx/sites-available/myproject`

```
server {
    listen 80;
    server_name yourdomain.com;
    location = /favicon.ico { access_log off; log_not_found off; }
    
    location /static/ {
        root /home/user/myproject/src/myproject;
    }
    
    location / {
        include proxy_params;
        proxy_pass http://unix:/home/user/myproject/src/myproject.sock;
    }
}
```

```bash
sudo ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled
sudo systemctl restart nginx
```


