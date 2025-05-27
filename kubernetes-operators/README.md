minikube delete --all --purge
rm -fr /tmp/ju* /tmp/k9* /tmp/mini* && ll /tmp
minikube start --force
kubectl label node minikube homework=true
helm dependency build
helm install homework .

kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 80:80

kubectl delete mysqls mysql-instance -n default



kubectl apply -f serviceAccount_mysql.yaml -f clusterRole.yaml -f clusterRoleBinding.yaml -f customResourceDefinition.yaml -f mysql.yaml -f deployment.yaml

Есть задание со *. 
Изменить манифест ClusterRole, описав в нем минимальный набор прав доступа необходимых для нашего CRD и убедиться что функциональность не пострадала
● Управление самим ресурсом CRD
● Создание и удаление ресурсов типа Service, PV, PVC
Правльно ли я понимаю, что clusterRole для этого должна выглядеть так:
### код ###
- apiGroups: ["otus.homework"]
  resources: ["mysqls"]
  verbs: ["create", "delete", "update"]


curl homework.otus/homepage
curl homework.otus/conf/dbuser
curl homework.otus/conf/dbpass
curl homework.otus/conf/dbconfig
curl homework.otus/metrics/metrics.html
kubectl --kubeconfig=kubernetes-security/kubeconfig.yaml get pods -n homework

## В процессе сделано:
Создан helm-chart. Все имеющиеся манифесты переписаны
Репозиторий и тег образа задаются разными параметрами - {{ .Values.app.deployment.initContainers.image.repository }} и {{ .Values.app.deployment.initContainers.image.tag }}
Пробы включаются и отключаются через параметр .Values.probes
После установки кластера отображаются ссылки на ресурсы; ссылки прописаны в файле NOTES.txt
В зависимости добавлен чарт ingress-nginx

## Как запустить проект:
 - В каталоге с проектом выполнить команды:
```
# Прописать сопоставление имени в хостовой машине
sudo echo '127.0.0.1 homework.otus' > /etc/hosts

 # Присвоить выбранной ноде метку homework
kubectl label node <node_name> homework=true

# Загрузить и подготовить зависимости 
helm dependency build

# Установить чарт
helm install homework .
```
## Как проверить работоспособность:
 Как проверить работоспособность:
Пробросить порт из хостовой машины в кластер
```
kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 80:80
```
Из соседнего терминала проверить доступность ресурсов
```
curl homework.otus/homepage
curl homework.otus/conf/dbuser
curl homework.otus/conf/dbpass
curl homework.otus/conf/dbconfig
curl homework.otus/metrics/metrics.html
```
Для проверки работоспособност kubeconfig выполнить команду. В выводе должен быть список всех подов из namespace homework
```
kubectl --kubeconfig=templates/kubernetes-security/kubeconfig.yaml get pods -n homework
```