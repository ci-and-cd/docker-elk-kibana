# docker-kibana

Kibana (part of ELK stack)

[Official](https://www.elastic.co/guide/en/kibana/current/_pulling_the_image.html)
[Official Dockerfile on Github](https://github.com/elastic/kibana-docker)
[Official Github](https://github.com/elastic/kibana)
[Deprecated repo on Docker Hub](https://hub.docker.com/_/kibana/)


Remove X-Pack from Kibana:
```bash
kibana-plugin remove x-pack
```

```text
PUT .kibana/_mapping/_doc?include_type_name=true
{
  "properties": {
     "type": { 
       "type":     "text",
       "fielddata": true
     }
  }
}
# or
PUT .kibana/_mapping/_doc?include_type_name=true
{
    "type": {
        "type": "text",
        "fielddata": true,
        "fields": {
            "keyword": {
                "type": "keyword"
            }
        }
    }
}
```

