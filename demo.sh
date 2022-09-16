
echo "\nAPPLICATION: UI\n"

read

docker container ls
echo "\nDOCKER: docker container ls\n"

read 

docker exec -it cassandra cqlsh -e "DESCRIBE table twitter.tweet_by_id;"
echo "\nCASSANDRA: DESCRIBE table twitter.tweet_by_id\n"

read

docker exec -it cassandra cqlsh -e "select * from twitter.tweet_by_id"
echo "\nCASSANDRA: select * from twitter.tweet_by_id\n"

read

docker exec -it cassandra cqlsh -e "select count(*) from twitter.tweet_by_id"
echo "\nCASSANDRA: select count(*) from twitter.tweet_by_id\n"

read

docker exec -it cassandra cqlsh -e "select count(*) from twitter.tweet_by_id"
echo "\nCASSANDRA: select count(*) from twitter.tweet_by_id\n"

echo "\nGRAFANA: SHOW METRICS\n"

read

echo "\nUPPER TERMINAL: /bin/kafka-console-consumer --topic from-pulsar --bootstrap-server localhost:9092\n"

read

docker-compose -f docker-compose-2.yml down
echo "APPLICATION: stop\n"

read 

docker container ls
echo "\nDOCKER: docker container ls\n"

read

docker exec -it cassandra cqlsh -e "INSERT INTO twitter.tweet_by_id (id, createdat, lang, sentiment, tweet) VALUES ('5b6962dd-3f90-4c93-8f61-eabfa4a803e2', '2022-04-11T13:58:26.132432', 'en', 3, 'Hello Cassandra Day Berlin!!!');"
echo "\nCASSANDRA: INSERT INTO twitter.tweet_by_id (id, createdat, lang, sentiment, tweet) VALUES ('5b6962dd-3f90-4c93-8f61-eabfa4a803e2', '2022-04-11T13:58:26.132432', 'en', 3, 'Hello Cassandra Day Berlin!!!')\n"

read

docker exec -it cassandra cqlsh -e "UPDATE twitter.tweet_by_id SET tweet='Nice you are all at Cassandra Day Berlin!!!' WHERE id='5b6962dd-3f90-4c93-8f61-eabfa4a803e2';"
echo "\nCASSANDRA: UPDATE twitter.tweet_by_id SET tweet='Nice you are all here at Cassandra Day Berlin!!!' WHERE id='5b6962dd-3f90-4c93-8f61-eabfa4a803e2'\n"

read

docker exec -it cassandra cqlsh -e "DELETE tweet FROM twitter.tweet_by_id WHERE id='5b6962dd-3f90-4c93-8f61-eabfa4a803e2';"
echo "\nCASSANDRA: DELETE tweet FROM twitter.tweet_by_id WHERE id='5b6962dd-3f90-4c93-8f61-eabfa4a803e2'\n"