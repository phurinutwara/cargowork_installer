# cargowork_installer
Shell scripts for CargoWork services

This script is used for clone 3 cargowork services including 

- `wms-service` 
- `wms-aotga` 
- `know_graph_service` 

and also gives `autorun.sh` which use `pm2` to easily manage all those services

---

## Table of Contents

- [[#📚 Prerequisite tools]]
- [[#💾 Installation]]

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

Extract the file by use `unzip` command

```sh
unzip cargowork_installer_v1_0_0.zip -d ~/cargowork_installer_v1_0_0
```

Use terminal and `cd` to extracted folder directory:

```sh
cd ./cargowork_installer_v1_0_0
```

Grant execution permissions to shell script and run it by the following command
and it will prompt you to enter bitbucket username and password, enter it.

```sh
chmod +x ./cargowork_cloner.sh
sh cargowork_cloner.sh
```

Wait until the cloner done its 3 clones, you will get `cargowork` folder. just cd it to get inside directory

```sh
cd ./cargowork
```

Use `autorun.sh` to automatically run 3 core-services with ease by using `sh [file]` command

```sh
chmod +x ./autorun.sh
sh ./autorun.sh
```

\*\* If you accidentally press CTRL+C to quite to pm2 monitor dashboard, you can view it again by
```sh
pm2 monit
```
