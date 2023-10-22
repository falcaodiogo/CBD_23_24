package detia.ua.pt;

import redis.clients.jedis.Jedis;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import org.bson.Document;

public class readWriteSpeed {

    public static void main(String[] args) {
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
        MongoDatabase database = mongoClient.getDatabase("mongodb_speed_test");
        MongoCollection<Document> collection = database.getCollection("test_collection");

        Jedis jedis = new Jedis("localhost");

        int numOperations = 1000;

        long mongoStartTime = System.currentTimeMillis();
        for (int i = 0; i < numOperations; i++) {
            Document doc = new Document("key", "value" + i);
            collection.insertOne(doc);
        }
        long mongoEndTime = System.currentTimeMillis();
        System.out.println("MongoDB Write Time: " + (mongoEndTime - mongoStartTime) + " ms");

        long jedisStartTime = System.currentTimeMillis();
        for (int i = 0; i < numOperations; i++) {
            jedis.set("key" + i, "value" + i);
        }
        long jedisEndTime = System.currentTimeMillis();
        System.out.println("Jedis (Redis) Write Time: " + (jedisEndTime - jedisStartTime) + " ms");

        mongoStartTime = System.currentTimeMillis();
        for (int i = 0; i < numOperations; i++) {
            Document result = collection.find(Filters.eq("key", "value" + i)).first();
        }
        mongoEndTime = System.currentTimeMillis();
        System.out.println("MongoDB Read Time: " + (mongoEndTime - mongoStartTime) + " ms");

        jedisStartTime = System.currentTimeMillis();
        for (int i = 0; i < numOperations; i++) {
            String value = jedis.get("key" + i);
        }
        jedisEndTime = System.currentTimeMillis();
        System.out.println("Jedis (Redis) Read Time: " + (jedisEndTime - jedisStartTime) + " ms");

        mongoClient.close();
        jedis.close();
    }
}

