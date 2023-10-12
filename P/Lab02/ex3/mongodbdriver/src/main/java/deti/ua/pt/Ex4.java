package deti.ua.pt;

import java.util.List;
import java.util.Map;

import org.bson.Document;
import org.bson.conversions.Bson;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

public class Ex4 {

    static MongoClient mongoClient;
    static MongoDatabase database;
    static MongoCollection<Document> collection;

    public static void main(String[] args) {

        // Configurar a conexão com o MongoDB
        mongoClient = MongoClients.create("mongodb://localhost:27017");

        // Acessar o banco de dados
        database = mongoClient.getDatabase("cbd");

        // Acessar a coleção "restaurantes"
        collection = database.getCollection("restaurants");

        
        
    }

    // Numero de localidades distintas
    public int countLocalidades() {
        
        Bson filter5 = Filters.ne(null, null);
        FindIterable<Document> documents5 = collection.find(filter5);

        MongoCursor<Document> cursor5 = documents5.iterator();
        while (cursor5.hasNext()) {
            System.out.println(cursor5.next() + "\n");
        }

        return 0;
    }

    public Map<String, Integer> countRestByLocalidade() {
        return null;
    }

    public List<String> getRestWithNameCloserTo(String name) {
        return null;
    }
    
}
