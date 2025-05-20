#!/bin/bash
TOKEN=$(kubectl get secret homework-secret -n homework -o jsonpath='{.data.token}' | base64 -d)
TOKEN64=$(kubectl get secret monitoring-secret -n homework -o jsonpath='{.data.token}' | base64 | tr -d '\r\n' | base64 -d)
URL=$(kubectl config view -o jsonpath='{.clusters[0].cluster.server}')
URL64=$(kubectl config view -o jsonpath='{.clusters[0].cluster.server}' | base64)
CA=$(kubectl get secret homework-secret -n homework -o jsonpath='{.data.ca\.crt}')

sed -i 's|certificate-authority-data: .*|certificate-authority-data: '$CA'|g' kubernetes-security/kubeconfig.yaml
sed -i 's|server: .*|server: '$URL'|g' kubernetes-security/kubeconfig.yaml
sed -i 's|token: .*|token: '$TOKEN'|g' kubernetes-security/kubeconfig.yaml

sed -i 's|TOKEN: .*|TOKEN: "'$TOKEN64'"|g' kubernetes-security/secret_metrics.yaml
sed -i 's|URL: .*|URL: "'$URL64'"|g' kubernetes-security/secret_metrics.yaml