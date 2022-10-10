# K8s_vagrant
set up kubernetes cluser with Vagrant 

# **Prérequis**
il faut installer au préalable les outils suivants:
 - Virtualbox
 - vagrant
 
 # installation du plugin vagrant
```shell
vagrant plugin install vagrant-hostsupdater
```
# Mise en place du cluster
```shell
git clone https://github.com/DjaloS/K8s_vagrant.git
cd K8s_vagrant
vagrant up
```
# connection au master cluster:  
```shell
vagrant ssh master 
```
# suppression du cluster: 
```shell
vagrant destroy -f
```


   


