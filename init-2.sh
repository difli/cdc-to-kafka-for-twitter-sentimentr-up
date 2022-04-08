docker exec -it pulsar /pulsar/bin/pulsar-admin sinks create --name tweet-db-sink --sink-type cassandra-enhanced --inputs persistent://public/default/to-db --sink-config-file /etc/cassandra-sink-connector/tweet-db-sink.yml
docker exec -it pulsar /pulsar/bin/pulsar-admin functions create --jar /pulsar/connectors/twitter-router-0.0.1-SNAPSHOT.jar --function-config-file /etc/twitter-router-function/twitter-router-function.yaml
docker exec -it pulsar /pulsar/bin/pulsar-admin source create --name cassandra-source-tweet_by_id --archive /pulsar/connectors/pulsar-cassandra-source-1.0.1.nar \
--tenant public \
--namespace default \
--destination-topic-name public/default/data-twitter.tweet_by_id \
--parallelism 1 \
--source-config '{
    "events.topic": "persistent://public/default/events-twitter.tweet_by_id",
    "keyspace": "twitter",
    "table": "tweet_by_id",
    "contactPoints": "cassandra",
    "port": 9042,
    "loadBalancing.localDc": "datacenter1",
    "auth.provider": "PLAIN"
}'
docker exec -it pulsar /pulsar/bin/pulsar-admin sinks create --name kafka-sink --sink-type kafka --inputs persistent://public/default/data-twitter.tweet_by_id --sink-config-file /etc/kafka-connector.yaml
# docker exec -it pulsar /pulsar/bin/pulsar-client consume public/default/data-twitter.tweet_by_id -s tweet-data -n 60 -r 1
docker exec -it kafka /bin/kafka-console-consumer --topic from-pulsar --bootstrap-server localhost:9092
