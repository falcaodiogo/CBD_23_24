package deti.ua.pt;

import java.util.logging.Level;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;

public class Ex1_insert {

    public static void main(String[] args) {
        java.util.logging.Logger.getLogger("org.mongodb.driver").setLevel(Level.SEVERE);
        MongoClient mongo = new MongoClient("localhost", 27017);
        MongoCollection<Document> coll = mongo.getDatabase("test").getCollection("inventory");
        Document doc = new Document("item", "database")
            .append("qty", 1)
            .append("status","M");
        
        coll.insertOne(doc);

        FindIterable<Document> docs = coll.find();
        
        for (Document d : docs)
            System.out.println(d.toJson());

        mongo.close();
    }
    
}
