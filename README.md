# K8s_vagrant
set up kubernetes cluser with Vagrant 

# step 1:
install vagrant and virtualbox on your machine 

# Step 2 :

Install vagrant-hostsupdater plugin with the command :
vagrant plugin install vagrant-hostsupdater

# step 3: Usage/Examples

To provision the cluster, execute the following commands.

git clone https://github.com/DjaloS/K8s_vagrant.git

cd K8s_vagrant

vagrant up


# Connect to the deployed VM with the following command:  

vagrant ssh "the name of your VM"

# Delete the stack with the command: 
  
vagrant delete "name of your stack or VM"
  
