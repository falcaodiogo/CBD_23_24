package deti.ua.pt;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

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

        System.out.println(countLocalidades());

        System.out.println(countRestByLocalidade());

        getRestWithNameCloserTo("Park").forEach(System.out::println);
        
    }

    // Numero de localidades distintas
    public static int countLocalidades() {

        int contador = 0;

        for (String d: collection.distinct("localidade", String.class)) {
            contador+=1;
        }

        return contador;
        
    }

    public static Map<String, Integer> countRestByLocalidade() {
        Map<String, Integer> count = new HashMap<>();

        for (String d: collection.distinct("localidade", String.class)) {
            Bson filter1 = Filters.eq("localidade", d);
            FindIterable<Document> documents = collection.find(filter1);
            int contador = 0;
            MongoCursor<Document> cursor = documents.iterator();
            while (cursor.hasNext()) {
                contador+=1;
                cursor.next();
            }
            count.put(d, contador);
        }

        return count;
    }

    public static List<String> getRestWithNameCloserTo(String name) {
        List<String> names = new ArrayList<>();

        Bson filter = Filters.regex("nome", Pattern.compile(Pattern.quote(name), Pattern.CASE_INSENSITIVE));
        // Bson projection = Projections.fields(Projections.include("nome"));
        FindIterable<Document> documents = collection.find(filter);

        MongoCursor<Document> cursor = documents.iterator();
        while (cursor.hasNext()) {
            names.add(cursor.next().toJson());
        }

        return names;
    }
    
}
