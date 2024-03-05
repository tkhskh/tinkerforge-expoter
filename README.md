# tinkerforge-expoter
## required
node-exporter (text collecter) 
tinkerforge brickd  
tinkerforge shell bindings  
bc  

## install
### node-exporter
```
apt install prometheus-node-exporter-collectors
```

### tinkerforge brickd 
```
wget https://download.tinkerforge.com/tools/brickd/linux/brickd_linux_latest_armhf.deb
dpkg -i brickd_linux_latest_armhf.deb
```

### tinkerforge shell bindings
```
mkdir tinkerforge
cd tinkerforge
wget https://download.tinkerforge.com/bindings/shell/tinkerforge_shell_bindings_latest.zip  
unzip tinkerforge_shell_bindings_latest.zip  
```

### bc
```
apt install bc
```

## crontab
```
crontab -e
```
```
### tinkerforge-exporter ###
* * * * * /root/tinkerforge/get-tinkerforge.sh
```
