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
# connection au machines duc cluster:  
```shell
vagrant ssh "the name of your VM"
```
# suppression des machines: 
```shell
vagrant delete "name of your stack or VM"
```

# les fichier concerneres:

_Vagrantfile_
_requirements.yml_
_install_kubernetes.yml_

# Vagrantfile

C'est à partir du fichier Vagrantfile que toute la procédure débute. Ce fichier décrit comment les machines seront configurées et provisionnées.
Merci de de consulter le Vagrantfile pour plus d'information.
Si on exécute le Vagrantfile, nous obtiendrons la configuration suivante sur nos VMs :
 - Création de cinq nœuds (1 Master et 3 Worker) tournant sous la distribution centos7 fait geerlingguy.

 - Création d'un réseau Virtualbox HOST ONLY, utilisé pour accéder au master et worker Kubernetes depuis notre machine hôte, avec notamment :

        Le master nommé master et possédant l'ip 192.168.56.10
        Le worker nommé worker-1 et possédant l'ip 192.168.56.101
        Le worker nommé worker-2 et possédant l'ip 192.168.56.102
        Le worker nommé worker-3 et possédant l'ip 192.168.56.103
        

Les outils indispensables pour le cluster Kubernetes seront installés et configurées par le scripte install_kubernetes.s et du playbook ansible install_kubernetes.yml comme on peut le voir ci-dessous:

```shell
#!/bin/bash
yum -y update
yum -y install epel-release

# install ansible
yum -y install ansible
# retrieve ansible code
yum -y install git
rm -rf DjaloS || echo "previous folder removed"
git clone https://github.com/DjaloS/K8s_vagrant.git
cd K8s_vagrant
ansible-galaxy install -r requirements.yml
if [ $1 == "master" ]
then
        ansible-playbook install_kubernetes.yml --extra-vars "kubernetes_role=$1 kubernetes_apiserver_advertise_address=$2"
        echo "###################################################"
        echo "For this Stack, you will use $(ip -f inet addr show enp0s8 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p') IP Address"
        echo "You need to be root to use kubectl in $(ip -f inet addr show enp0s8 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p') VM (run 'sudo su -' to become root and then use kubectl as you want)"
        echo "###################################################"
else
        ansible-playbook install_kubernetes.yml --extra-vars "kubernetes_role=$1 kubernetes_apiserver_advertise_address=$2 kubernetes_join_command='kubeadm join {{ kubernetes_apiserver_advertise_address }}:6443 --ignore-preflight-errors=all --token={{ token }}  --discovery-token-unsafe-skip-ca-verification'"
        echo "For this Stack, you will use $(ip -f inet addr show enp0s8 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p') IP Address"
fi
```

Ce script install d'abord les outils ansible, git ainsique les packages epel-release. Ensuite il git clone le depôt git, ce positione et install prepare la machine en executant la commande ansible-galaxy install -r requirements.yml qui install les roles nécessaires (voir requirements.yml). cette tâche est effectué sur cahque machine. 
Ansible galaxy est c'est un depot dans lequel ansibel va recuperer les rôles (preciser dans le fichier requirements.yml) : **pip, docker et kubernetes**.

Il execute sur le master la première commande qui initialise le nœud maître  Kubernetes (kubeadm init) ou il est spécifié en tant que paramètres, l'IP du serveur API, le nom du cluster, et la plage IP des pods. Une fois le nœud master initialisé, l'étape suivante consiste à gérer la partie réseau du cluster de manière à connecter les divers modules sur les différents nœuds du cluster. Pour cela, il install le plugin CNI (Container Network Interface) weave net. 

La commande du else fait permet de faire la joinction des workers nodes au master à travers le token preciser dans le playbook install_kubernetes.yml.

Après chaque if, il affiche l'IP de la machine et quelques instructions pratiques.

Les connexions internes entre les PODs Kubernetes se passeront depuis un réseau privé sur la plage IP 192.168.0.0/16. Ces adresses IPs ne seront pas accessibles de l'extérieur du cluster Kubernetes et changeront lorsque les PODs seront détruits et créés.


```yaml


```
   


