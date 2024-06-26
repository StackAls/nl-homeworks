
# Домашняя работа к занятию «Микросервисы: принципы»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.

## Задача 1: API Gateway

Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных программных решений. На основе таблицы сделайте выбор решения.

Решение должно соответствовать следующим требованиям:

- маршрутизация запросов к нужному сервису на основе конфигурации,
- возможность проверки аутентификационной информации в запросах,
- обеспечение терминации HTTPS.

Обоснуйте свой выбор.

---

### <span style="color:red"> Ответ </span>

На данный момент существует множество решений подходящих под эти требования. Например:

- nginx
- traefik
- HAproxy
- envoy
- Angie
- Caddy
Таблицу возможностей этих решений не особо имеет смысла приводить - т.к. у нас уже есть ТЗ с необходимыми для бизнеса задачами и указанные продукты им соответствуют. Здесь выбрать необходимо решение наиболее простое и доступное.

Оптимальным для данного технического задания я считаю - nginx.
Это довольно сильно распространенный продукт и работать с ним умеют множество IT специалистов.
Так же он достаточно высокопроизводительный и при этом легковесный.

---

## Задача 2: Брокер сообщений

Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения.

Решение должно соответствовать следующим требованиям:

- поддержка кластеризации для обеспечения надёжности,
- хранение сообщений на диске в процессе доставки,
- высокая скорость работы,
- поддержка различных форматов сообщений,
- разделение прав доступа к различным потокам сообщений,
- простота эксплуатации.

Обоснуйте свой выбор.

---

### <span style="color:red"> Ответ </span>

Наиболее популярны брокеры сообщений RabbitMQ, Apache Kafka, Redis Streams, ActiveMQ

[Таблица сравнений брокеров сообщений](https://ultimate-comparisons.github.io/ultimate-message-broker-comparison/)

Лучшим решением для данного технического задания являются Apache Kafka и RabbitMQ. Эти программные продукты - лидеры этого направления.
Оптимальным решением представляется RabbitMQ. По сравнению с Apache Kafka он более прост в настройке, по нему больше опубликовано различных решений, а так же с ним знакомо большее количество IT специалистов. При этом разница в производительности Apache Kafka и RabbitMQ начинает быть заметна при очень высоком количестве сообщений (но это обеспечивается за счёт горизонтального масштабирования), однако по задержке (латентности) доставки сообщений оба решения на одном уровне.

---

## Задача 3: API Gateway * (необязательная)

### Есть три сервиса

**minio**

- хранит загруженные файлы в бакете images,
- S3 протокол,

**uploader**

- принимает файл, если картинка сжимает и загружает его в minio,
- POST /v1/upload,

**security**

- регистрация пользователя POST /v1/user,
- получение информации о пользователе GET /v1/user,
- логин пользователя POST /v1/token,
- проверка токена GET /v1/token/validation.

### Необходимо воспользоваться любым балансировщиком и сделать API Gateway

**POST /v1/register**

1. Анонимный доступ.
2. Запрос направляется в сервис security POST /v1/user.

**POST /v1/token**

1. Анонимный доступ.
2. Запрос направляется в сервис security POST /v1/token.

**GET /v1/user**

1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
2. Запрос направляется в сервис security GET /v1/user.

**POST /v1/upload**

1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
2. Запрос направляется в сервис uploader POST /v1/upload.

**GET /v1/user/{image}**

1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
2. Запрос направляется в сервис minio GET /images/{image}.

### Ожидаемый результат

Результатом выполнения задачи должен быть docker compose файл, запустив который можно локально выполнить следующие команды с успешным результатом.
Предполагается, что для реализации API Gateway будет написан конфиг для NGinx или другого балансировщика нагрузки, который будет запущен как сервис через docker-compose и будет обеспечивать балансировку и проверку аутентификации входящих запросов.
Авторизация
curl -X POST -H 'Content-Type: application/json' -d '{"login":"bob", "password":"qwe123"}' <http://localhost/token>

**Загрузка файла**

curl -X POST -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJib2IifQ.hiMVLmssoTsy1MqbmIoviDeFPvo-nCd92d4UFiN2O2I' -H 'Content-Type: octet/stream' --data-binary @yourfilename.jpg <http://localhost/upload>

**Получение файла**
curl -X GET <http://localhost/images/4e6df220-295e-4231-82bc-45e4b1484430.jpg>

---

### [Дополнительные материалы: как запускать, как тестировать, как проверить](https://github.com/netology-code/devkub-homeworks/tree/main/11-microservices-02-principles)

---

### <span style="color:red"> Ответ </span>

Исправлен файл [gateway/nginx.conf на default.conf](./11-microservices-02-principles/gateway/default.conf)

Исправлен файл [security/requirements.txt](./11-microservices-02-principles/security/requirements.txt) - иначе сервис не работает.

К сожалению не удалось разобраться почему из minio не загружается картинка.

![screen](./screen/screen2.png)
