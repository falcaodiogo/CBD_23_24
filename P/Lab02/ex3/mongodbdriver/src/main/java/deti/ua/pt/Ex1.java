package deti.ua.pt;

import org.bson.Document;

import com.mongodb.MongoException;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;

public class Ex1 
{
    public static void main(String[] args) {
        // Configurar a conexão com o MongoDB
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");

        // Acessar o banco de dados
        MongoDatabase database = mongoClient.getDatabase("cbd");

        // Acessar a coleção "restaurantes"
        MongoCollection<Document> collection = database.getCollection("restaurants");

        // LIST ****************************************
        for (Document document : collection.find()) {
            System.out.println(document.toJson() + "\n");
        }

        // UPDATE ****************************************
        // Filtrar o documento pelo ID
        String restauranteId = "65154405bcf8bb27b134afe5";
        Document filtro = new Document("_id", new Document("$oid", restauranteId));

        // Executar a atualização
        collection.updateOne(Filters.eq("_id", filtro), Updates.set("nome", "New National Bakery"));

        System.out.println("Nome do restaurante atualizado com sucesso.");

        // INSERT ****************************************
        // {"_id": {"$oid": "65154405bcf8bb27b134afdf"}, "address": {"building": "145", "coord": [-73.986544, 40.7337697], "rua": "3 Avenue", "zipcode": "10003"}, "localidade": "Manhattan", "gastronomia": "Café/Coffee/Tea", "grades": [{"date": {"$date": 1411344000000}, "grade": "A", "score": 5}, {"date": {"$date": 1379980800000}, "grade": "A", "score": 9}, {"date": {"$date": 1349913600000}, "grade": "A", "score": 11}, {"date": {"$date": 1320019200000}, "grade": "A", "score": 12}], "nome": "Starbucks Coffee", "restaurant_id": "40899767"}
        // collection.insertOne()
        try {
            collection.updateOne(new Document("_id", new Document("$oid", "65254405bcf8bb27b134afdf"))
                .append("nome", "Novo Restaurante")
                .append("localidade", "Local")
                .append("gastronomia", "Tipo de Gastronomia")
                .append("address", new Document()), filtro);
            } catch (MongoException me) {
                System.err.println("Unable to insert due to an error: " + me);
            }
    }
}
