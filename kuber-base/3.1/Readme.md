# Домашняя работа к занятию «Компоненты Kubernetes»

## Цель задания

Рассчитать требования к кластеру под проект

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

- [Considerations for large clusters](https://kubernetes.io/docs/setup/best-practices/cluster-large/),
- [Architecting Kubernetes clusters — choosing a worker node size](https://learnk8s.io/kubernetes-node-size).

------

## Задание. Необходимо определить требуемые ресурсы

Известно, что проекту нужны база данных, система кеширования, а само приложение состоит из бекенда и фронтенда. Опишите, какие ресурсы нужны, если известно:

1. Необходимо упаковать приложение в чарт для деплоя в разные окружения.
2. База данных должна быть отказоустойчивой. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии.
3. Кеш должен быть отказоустойчивый. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии.
4. Фронтенд обрабатывает внешние запросы быстро, отдавая статику. Потребляет не более 50 МБ ОЗУ на каждый экземпляр, 0.2 ядра. 5 копий.
5. Бекенд потребляет 600 МБ ОЗУ и по 1 ядру на копию. 10 копий.

------

### Правила приёма работы

1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Сначала сделайте расчёт всех необходимых ресурсов.
3. Затем прикиньте количество рабочих нод, которые справятся с такой нагрузкой.
4. Добавьте к полученным цифрам запас, который учитывает выход из строя как минимум одной ноды.
5. Добавьте служебные ресурсы к нодам. Помните, что для разных типов нод требовния к ресурсам разные.
6. В результате должно быть указано количество нод и их параметры.

------

## Ответ на задание

### Расчёт минимальной необходимых ресурсов для запуска приложения или для тестового окружения

| Ресурс        | СУБД  | Кэш    | Фронтенд     | Бэкенд       | Итого       |
|---------------|-------|--------|--------------|--------------|-------------|
| CPU (ядер)    |  1    |   1    |    0.2       |   1          |   4         |
| Mem (ГБ)      |  4    |   4    |    0.05      |   0.6        |   9         |

Так же необходимы ресурсы для кластера - мастер-нода 2 ядра 2 ГБ, две воркер-ноды 1 ядро 1 ГБ.

Таким образом минимальные ресурсы для запуска приложения - 16 ядер CPU 13 ГБ Mem.

### Расчёт минимальной необходимых ресурсов для запуска приложения в отказоустойчивом режиме

| Ресурс        | СУБД  | Кэш    | Фронтенд     | Бэкенд       | Итого  (min)|
|---------------|-------|--------|--------------|--------------|-------------|
| CPU (ядер)    |  3    |   3    |    1         |   10         |   16(15)    |
| Mem (ГБ)      |  12   |   12   |    0.25      |   6          |   32(31)    |

Так же необходимы ресурсы для кластера kubernetes - мастер-нода 4 ядра 4 ГБ, две воркер-ноды 2 ядро 2 ГБ.

Таким образом необходимы ресурсы для запуска приложения в прод - 24 ядер CPU 40 ГБ Mem.

Однако, исходя из требований ТЗ по отказоустойчивости, желательно кластер СУБД размещать на трёх отдельных виртуальных машинах.
Кластер же kubernetes стоит собрать из 5 воркер нод распределив нагрузку и (на каждую ноду по 1 фронтенду и 2 бэкенда)

Так же необходимо будет поднять:

- сетевой балансировщик,
- систему мониторинга и управления кластером СУБД,
- систему мониторинга и управления кластером kubernetes,
- систему сбора и анализа логов,
- другие системы которые могут появиться в результате анализа системы (DNS, OAuth, s3 storage, ...)

Все эти задачи так же потребуют ресурсов, которые необходимо согласовать с командой и бизнесом.
