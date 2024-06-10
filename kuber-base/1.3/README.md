# Домашнее задание к занятию «Запуск приложений в K8S»

### Цель задания

В тестовой среде для работы с Kubernetes, установленной в предыдущем ДЗ, необходимо развернуть Deployment с приложением, состоящим из нескольких контейнеров, и масштабировать его.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Описание](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) Deployment и примеры манифестов.
2. [Описание](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) Init-контейнеров.
3. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool.

------

### Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod

1. Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку.
2. После запуска увеличить количество реплик работающего приложения до 2.
3. Продемонстрировать количество подов до и после масштабирования.
4. Создать Service, который обеспечит доступ до реплик приложений из п.1.
5. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложений из п.1.

------

### Ответ на задание 1

1. Разворачиваем Deployment

```bash
# разворачиваем приложение
kubectl apply -f app/deployment.yml

# проверяем
kubectl get deployment
kubectl get pods

# смотрим логи
kubectl logs deployments/myapp-13 -c nginx
kubectl logs deployments/myapp-13 -c multitool

```

![screen](./screen/2024-06-10_17-50.png)

![screen](./screen/2024-06-10_17-58.png)

Имеется ошибка развертывания приложения - занят порт 80.

Для корректной работы multitool необходимо указать рабочие порты [например из документации](https://github.com/wbitt/Network-MultiTool/blob/master/kubernetes/multiool-daemonset.yml)

[Файл deployment.yml](./app/deployment.yml)

Приложение успешно развернуто.
![screen](./screen/2024-06-10_18-39.png)

2 , 3. Увеличиваем количество реплик.

![screen](./screen/2024-06-10_18-44.png)

4. Создаю [сервис service.yml](./app/service.yml)

![screen](./screen/2024-06-10_18-55.png)

5. Создаю [Pod multi.yml](./app/multi.yml)

![screen](./screen/2024-06-10_21-56.png)

------

### Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

1. Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения.
2. Убедиться, что nginx не стартует. В качестве Init-контейнера взять busybox.
3. Создать и запустить Service. Убедиться, что Init запустился.
4. Продемонстрировать состояние пода до и после запуска сервиса.

------

### Ответ на задание 2

Создаю Deployment приложения nginx.

[Файл nginx.yml](./app/nginx.yml)

Создаю Service

[Файл nginx-srv.yml](./app/nginx-srv.yml)

Результат
![screen](./screen/2024-06-10_22-29.png)

------
