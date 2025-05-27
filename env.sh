#!/bin/bash
TOKEN=$(kubectl get secret homework-secret -n homework -o jsonpath='{.data.token}' | base64 -d)
URL=$(kubectl config view -o jsonpath='{.clusters[0].cluster.server}')
CA=$(kubectl get secret homework-secret -n homework -o jsonpath='{.data.ca\.crt}')

sed -i 's|certificate-authority-data: .*|certificate-authority-data: '$CA'|g' templates/kubernetes-security/kubeconfig.yaml
sed -i 's|server: .*|server: '$URL'|g' templates/kubernetes-security/kubeconfig.yaml
sed -i 's|token: .*|token: '$TOKEN'|g' templates/kubernetes-security/kubeconfig.yaml