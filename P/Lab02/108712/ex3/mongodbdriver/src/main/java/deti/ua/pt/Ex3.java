package deti.ua.pt;

import org.bson.Document;
import org.bson.conversions.Bson;

import com.mongodb.BasicDBObject;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

public class Ex3 {

    public static void main(String[] args) {
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");

        MongoDatabase database = mongoClient.getDatabase("cbd");

        MongoCollection<Document> collection = database.getCollection("restaurants");

        
        // Ex 4
        Bson filter1 = Filters.eq("localidade", "Bronx");
        FindIterable<Document> documents = collection.find(filter1);

        int contador = 0;
        MongoCursor<Document> cursor = documents.iterator();
        while (cursor.hasNext()) {
            contador+=1;
            cursor.next();
        }
        System.out.println("Número de restaurantes: " + contador);

        // Ex 5
        Bson filter2 = Filters.eq("localidade", "Bronx");
        FindIterable<Document> documents2 = collection.find(filter2).sort(new BasicDBObject("nome", 1)).limit(15);

        MongoCursor<Document> cursor2 = documents2.iterator();
        while (cursor2.hasNext()) {
            System.out.println(cursor2.next() + "\n");
        }

        // Ex 6 
        Bson filter3 = Filters.gt("grades.score", 85);
        FindIterable<Document> documents3 = collection.find(filter3);

        MongoCursor<Document> cursor3 = documents3.iterator();
        while (cursor3.hasNext()) {
            System.out.println(cursor3.next() + "\n");
        }
        

        // Ex 7
        Bson filter4 = Filters.and(Filters.lt("grades.score", 100), Filters.gt("grades.score", 85));
        FindIterable<Document> documents4 = collection.find(filter4);

        MongoCursor<Document> cursor4 = documents4.iterator();
        while (cursor4.hasNext()) {
            System.out.println(cursor4.next() + "\n");
        }

        // Ex 8
        Bson filter5 = Filters.lt("address.coord.0", -95.7);
        FindIterable<Document> documents5 = collection.find(filter5);

        MongoCursor<Document> cursor5 = documents5.iterator();
        while (cursor5.hasNext()) {
            System.out.println(cursor5.next() + "\n");
        }
    }
    
}
