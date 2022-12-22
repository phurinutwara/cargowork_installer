This script is used for clone 3 cargowork services including 

- `wms-service` 
- `wms-aotga` 
- `know_graph_service` 

and also gives `autorun.sh` which use `pm2` to easily manage all those services

---

## Table of Contents

- [#📚 Prerequisite tools](#-prerequisite-tools)
- [#💾 Installation](#-installation)
- [#🎮 Usage](#-usage)

---

## 📚 Prerequisite tools

- Brew
- Git
- NPM (Node v16.x.x only)
- Yarn
- PM2
- openssl (v3+)

---

## 💾 Installation

> ℹ️ Please install all of prerequisite tools first before continue this section furthermore

1. Open terminal and clone the repository

	```sh
	cd ~/ && \
	git clone https://github.com/phurinutwara/cargowork_installer/ cargowork
	```

2. Grant execution permissions to shell script and run it by the following command

	```sh
	chmod +x ~/cargowork/cargowork_cloner.sh && \
	sh ~/cargowork/cargowork_cloner.sh
	```

	and it will prompt you to enter bitbucket username and password, enter it.
	(You can get from our discord channel at topic [#global-announcement](https://discord.com/channels/843782884581441536/844771471356461078/1054230944745263104))

	![attachments/Pasted image 20221219093839.png](<attachments/Pasted image 20221219093839.png>)

3. Wait until the cloner done its 3 clones, you will get `cargowork` folder.
   Then use `autorun.sh` to automatically run 3 core-services with ease by using `sh [file]` command

	```sh
	chmod a+x ~/cargowork/autorun.sh && \
	ln -s ~/cargowork/autorun.sh ~/cargowork_autorun 
	```

---

## 🎮 Usage

> 📓Please take a look on this section after done [#💾 Installation](#-installation) section first.
> 
> After you have installed services by `cargowork_cloner.sh`, you can use `autorun.sh` even you lose track of your current directory (`cd`) because the installer always install the project on your home directory (~/).

Try this command when you want to run services

```sh
~/cargowork_autorun
```

To list the services use this

```sh
pm2 ls
```

To stop services use this

```sh
pm2 stop all
```

To delete services from list use this

```sh
pm2 delete all
```

To show log and stream output on certain service use this

```sh
# Usage: logs [options] [id|name|namespace]

# if you want to log frontend service, try this
pm2 log wms-aotga

# if you want to log backend service, try this
pm2 log wms-service

# if you want to log graph service, try this
pm2 log know_graph_service
```

If you accidentally press CTRL+C to quite to pm2 monitor dashboard, you can view it again by

```sh
pm2 monit
```
