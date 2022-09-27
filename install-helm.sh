#!/bin/bash

echo "Install Helm"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin
./get_helm.sh
