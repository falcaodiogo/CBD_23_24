package deti.ua.pt;

import org.bson.Document;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Indexes;

public class Ex2 {

    public static void main(String[] args) {
        // Configurar a conexão com o MongoDB
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");

        // Acessar o banco de dados
        MongoDatabase database = mongoClient.getDatabase("cbd");

        // Acessar a coleção "restaurantes"
        MongoCollection<Document> collection = database.getCollection("restaurants");

        collection.createIndex(Indexes.ascending("localidade"));
        collection.createIndex(Indexes.ascending("gastronomia"));
        collection.createIndex(Indexes.text("nome"));

        // database.collection.detIndexes();
    }
    
}
