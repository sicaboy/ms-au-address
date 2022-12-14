
# Australian Address Typeahead Search by addressr, ElasticSearch (with Vue component and docker compose setup)

### Install

```
docker-compose up -d
```

### Usage

Backend API

```shell
# Typeahead / Search
curl -i http://localhost:8028/addresses?q=LEVEL+25,+TOWER+3

# Detail of location by PID
curl -i http://localhost:8028/addresses/GANSW720780715
```

Frontend Vue Component

see [./frontend](./frontend)
