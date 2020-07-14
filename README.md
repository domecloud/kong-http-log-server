# http-es-log-server

HTTP log server for Kong http-log plugin and Elasticsearch

![http-es-log-server-diagram](./http-es-log-server-diagram.png)

# Befor start

Edit .env file

```
HOST=0.0.0.0
PORT=8080
ES_HOST=elasticsearch
ES_PORT=9200
INDEX_PATTERN=kong-2006-01-02
```

**NOTE :**

- `HOST` and `PORT` for http-es-log-server binding
- `ES_HOST` and `ES_PORT` for ElasticSearch Server
- `INDEX_PATTERN` use Golang date format

Ref: [https://gobyexample.com/time-formatting-parsing](https://gobyexample.com/time-formatting-parsing)


# Start 'em all

```
docker-compose up -d kong-database
docker-compose up migrations
docker-compose up -d kong elasticsearch kibana http-es-log-server 
```

# Create sevice and route

```
curl http://127.0.0.1:8001/services -d name=httpbin -d url=http://httpbin.org
curl http://127.0.0.1:8001/services/httpbin/routes -d name=httpbin -d paths[]=/
```

# Add http-log plugin

```
curl http://127.0.0.1:8001/services/httpbin/plugins \
	-d name=http-log \
	-d config.http_endpoint=http://http-es-log-server:8080
```

# Kibana

```
http://127.0.0.1:5601
```