docker exec -it cassandra cqlsh -e "CREATE KEYSPACE twitter WITH replication = { 'class': 'NetworkTopologyStrategy', 'datacenter1': 1 };"
docker exec -it cassandra cqlsh -e "CREATE TABLE twitter.tweet_by_lang (lang text, createdat text, id text,sentiment int,tweet text,PRIMARY KEY (lang, createdat, id)) WITH CLUSTERING ORDER BY (createdat DESC, id DESC);"
docker exec -it cassandra cqlsh -e "CREATE TABLE twitter.tweet_by_id (lang text,createdat text,id text,sentiment int,tweet text,PRIMARY KEY (id)) WITH cdc=true;"
docker exec -it pulsar /pulsar/bin/pulsar-admin topics create persistent://public/default/from-twitterapi
docker exec -it pulsar /pulsar/bin/pulsar-admin topics create persistent://public/default/to-en-sentimentr
docker exec -it pulsar /pulsar/bin/pulsar-admin topics create persistent://public/default/to-db
docker exec -it kafka /bin/kafka-topics --create --topic from-pulsar --bootstrap-server localhost:9092

