# cdc-for-twitter-sentimentr-up
- clone the repo
```
git clone https://github.com/difli/cdc-for-twitter-sentimentr-up.git
```
- cd into folder
```
cd cdc-for-twitter-sentimentr-up
```
- delete all containers in case they exist
```
docker-compose -f docker-compose-1.yml down
docker-compose -f docker-compose-2.yml down
```
- start cassandra and pulsar, pulsar-dashboard
```
docker-compose -f docker-compose-1.yml up -d
```
- wait till cassandra is completely up and running
```
watch "docker exec -it cassandra nodetool status"
```
- run init-1 script to create keyspace, tables and topics
```
sh init-1.sh
```
- start the applications
- twitter-ui, twitter-loadgenerator and twitter-twitter-sentimentr-en-service
```
docker-compose -f docker-compose-2.yml up -d
```
- use your browser and load twitter-ui: [localhost:8081](http://localhost:8081) - will take a few seconds till the application is ready to respond
- create sinks, sources and function
```
sh init-2.sh
```
- done !!!
- you should now see realtime date in twitter-ui: [localhost:8081](http://localhost:8081)
- you should see cdc in action
- see the terminal where you executed "sh init-2.sh". There you see all mutations of table tweet_by_id. These mutations are streamed as events/messages to topic:' public/default/data-twitter.tweet_by_id'. You can consume this topic by any pulsar sink to downstream the data in realtime to the downstream technologies of your choice for various use cases to leverage your data.

## Monitoring
- grafana and prometheus is preconfigured with some pulsar dashboards
- open [localhost:3000](localhost:3000) in your browser
- login with admin/admin
- enjoy the preconfigured pulsar dashboards
![alt text](/images/grafana-topics.png)
