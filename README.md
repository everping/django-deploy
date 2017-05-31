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

Edit the `settings.py` file with your editor of choice:

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
```
