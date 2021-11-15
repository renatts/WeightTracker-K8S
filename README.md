# Node.js Weight Tracker

[![Build Status](https://dev.azure.com/parennut/Weight-Tracker-CICD/_apis/build/status/renatts.WeightTracker-Docker?branchName=master)](https://dev.azure.com/parennut/Weight-Tracker-CICD/_build/latest?definitionId=4&branchName=master)

---

## Database server configuration

* Connect to the remote server by using `ssh -i [path to id_rsa]/id_rsa ubuntu@[ database server IP address]`
* Run `sudo apt update` and `sudo apt upgrade`
* Install PostgreSQL 12 by using `sudo apt install postgresql-12`
* Test PostgreSQL connection `sudo su - postgres`
* Reset the password `psql -c "alter user postgres with password 'Y0urV3RYstr0nGpa22w0rD'"`
* `psql` and then `\conninfo` to see connection details.
* Configure remote connection by using `sudo nano /etc/postgresql/13/main/postgresql.conf`
* Uncomment line 59 and change the Listen address `listen_addresses = '*'`
* Also set PostgreSQL to accept remote connections from allowed hosts `sudo nano /etc/postgresql/13/main/pg_hba.conf`
* Add `host all all 0.0.0.0/0 md5`
* After the change, restart postgresql service `sudo systemctl restart postgresql`
* Install [pgAdmin4](https://computingforgeeks.com/how-to-install-pgadmin-4-on-ubuntu/) (not neccesary)
* For working with pgAdmin 4 open your browser at `http://[ServerIP_or_domain]/pgadmin4`
* Login by using email address and password
* Add a PostgreSQL server to administer with pgAdmin by clicking on `Add New Server`.
* Under the `General` section, give your server a name & description.
* Under `Connection` tab, provide access details – DB host, DB port, DB user and Password.
* Click `Save` button to save the configurations.
* If you were successful adding the server, the name will appear in the left sidebar

## App server configuration

* Connect to the remote server by using `ssh -i [path to id_rsa]/id_rsa ubuntu@[ app server IP address]`
* Install Git if neccesary with `sudo apt-get install git` 
* Clone that repo using `git clone https://github.com/renatts/bootcamp-app.git`
* Run `sudo apt install npm nodejs` (`node -v` `npm -v` for checking version)
* [Node.js](https://nodejs.org/) version must be 12.x or higher
* Initialize npm: `npm init -y`
* Run `sudo npm install` to install the dependencies
* Create a [free Okta developer account](https://developer.okta.com/) and add a web application for this app
* Don't forget to update `IP address` in applications section!
* Create `.env` file (like on the picture) and change the values to yours: 
![env_sample](https://user-images.githubusercontent.com/83014719/134813723-7f57c1ce-0361-4699-afe2-f79c647ec560.jpg)
* Initialize the PostgreSQL database by running `npm run initdb`
* Run `npm run dev` to start the application.

### Reboot configuration (App server)
* `sudo npm install pm2@latest -g`
* `sudo pm2 start npm -- run dev`
* `sudo pm2 save`
* `sudo pm2 startup`
* `sudo systemctl daemon-reload`
* `sudo systemctl enable pm2-root.service`
* `sudo systemctl status pm2-root.service` (for service status)

---



Or you can create your own [service](https://www.shubhamdipt.com/blog/how-to-create-a-systemd-service-in-linux/).
* For your service you will need to create a script file that will contain commands for booting your application.

