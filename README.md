# cdc-to-kafka-for-twitter-sentimentr-up
DataStax CDC for Apache Cassandra® is open-source software (OSS) that sends Cassandra mutations for tables having Change Data Capture (CDC) enabled to Luna Streaming or Apache Pulsar™, which in turn can write the data to any technology like for example platforms such as kafka.

This repo contains a CDC demo. The twitter-sentimentr application ingests data into cassandra. CDC streams all mutations of table tweet_by_id in near realtime to kafka.

- clone the repo
```
git clone https://github.com/difli/cdc-for-twitter-sentimentr-up.git
```
- cd into folder
```
cd cdc-to-kafka-for-twitter-sentimentr-up
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
- see the terminal where you executed "sh init-2.sh". There you see all mutations of table tweet_by_id. These mutations are streamed as events/messages to topic:' public/default/data-twitter.tweet_by_id'. The kafka connector consumes this topic and streams the data to the topic 'from-pulsar' in kafka.
![alt text](/images/kafka-console-consumer.png)

## Monitoring
- grafana and prometheus is preconfigured with some pulsar and kafka dashboards
- open [localhost:3000](localhost:3000) in your browser
- login with admin/admin
- enjoy the preconfigured pulsar dashboards

## Demo path
- datapipeline: ```twitter.tweet_by_id``` cassandra table -> DataStax Change Agent for Apache Cassandra -> ```public/default/event-twitter.tweet_by_id``` pulsar topic -> DataStax Cassandra Source Connector for Apache Pulsar -> ```public/default/data-twitter.tweet_by_id``` pulsar topic -> kafka sink connector for pulsar -> ```from-pulsar``` kafka topic
- query twitter.tweet_by_id table
```
docker exec -it cassandra cqlsh -e "select * from twitter.tweet_by_id"
```
or
```
docker exec -it cassandra cqlsh -e "select count(*) from twitter.tweet_by_id"
```
- show metrics for CDC pulsar topics 'public/default/event-twitter.tweet_by_id' and 'public/default/data-twitter.tweet_by_id' via grafana pulsar topic dashboard
![alt text](/images/grafana-topics.png)
- show metrics for kafka topic 'from pulsar'
![alt text](/images/from-pulsar-topic-kafka.png)
- see the terminal where you executed "sh init-2.sh". The output is from command
```
docker exec -it kafka /bin/kafka-console-consumer --topic from-pulsar --bootstrap-server localhost:9092
```
- There you see all mutations of table tweet_by_id. These mutations are streamed as events/messages to topic:' public/default/data-twitter.tweet_by_id'. The kafka connector consumes this topic and streams the data to the topic 'from-pulsar' in kafka which is consumed by the kafka-console-consumer cli. 
![alt text](/images/kafka-console-consumer.png)
