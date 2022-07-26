# K8s_vagrant
set up kubernetes cluser with Vagrant 

# step 1:
install vagrant and virtualbox on your machine 

# Step 2 :

Install vagrant-hostsupdater plugin with the command :
vagrant plugin install vagrant-hostsupdater

# Step 3: Deploy your cluster (stack) 

Deploy your cluster with the simple command line : vagrant up

Connect to the deployed VM : vagrant ssh <stack name>
  
Delete the stack with command:  vagrant delete <stack name>
  
