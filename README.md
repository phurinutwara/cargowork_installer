# cargowork_installer
Shell scripts for CargoWork services

This script is used for clone 3 cargowork services including 

- `wms-service` 
- `wms-aotga` 
- `know_graph_service` 

and also gives `autorun.sh` which use `pm2` to easily manage all those services

---

## Table of Contents

- [📚 Prerequisite tools](#-prerequisite-tools)
- [💾 Installation](#-installation)

---

## 📚 Prerequisite tools
- [ ] Brew
- [ ] Git
- [ ] NPM (Node v16.x.x only)
- [ ] Yarn
- [ ] PM2
- [ ] openssl (v3+)

---

## 💾 Installation

> ℹ️ Please install all of prerequisite tools first before continue this section furthermore

Open terminal and clone the repository

```sh
git clone https://github.com/phurinutwara/cargowork_installer/ cargowork && \
cd cargowork
```

Grant execution permissions to shell script and run it by the following command

```sh
chmod +x ./cargowork_cloner.sh && \
sh cargowork_cloner.sh
```

and it will prompt you to enter bitbucket username and password, enter it.
(You can get from our discord channel at topic [#global-announcement](https://discord.com/channels/843782884581441536/844771471356461078/1054230944745263104))


![Pasted image 20221219093839.png](https://raw.githubusercontent.com/phurinutwara/cargowork_installer/main/.attachments/Pasted%20image%2020221219093839.png)

Wait until the cloner done its 3 clones, you will get `cargowork` folder.
Then use `autorun.sh` to automatically run 3 core-services with ease by using `sh [file]` command

```sh
chmod +x ./autorun.sh
sh ./autorun.sh
```

\*\* If you accidentally press CTRL+C to quite to pm2 monitor dashboard, you can view it again by

```sh
pm2 monit
```
