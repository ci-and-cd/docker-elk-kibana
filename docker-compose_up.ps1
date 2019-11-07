
$p = (pwd) -replace "([A-Z]{1}):\\","/`$1/"
$env:PWD = ($p.substring(0,2).ToLower() + $p.substring(2)).replace("\", "/")
Get-ChildItem Env:PWD

$env:IMAGE_ARG_KIBANA_IMAGE_NAME = 'kibana'
#$env:ELASTICSEARCH_HOSTS = 'http://172.16.238.62:9200'

docker-compose down -v
docker-compose up -d
docker-compose logs -f
