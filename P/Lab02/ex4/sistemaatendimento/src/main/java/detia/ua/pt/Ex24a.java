package detia.ua.pt;

import java.io.FileWriter;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Map;
import java.util.Scanner;

import org.bson.Document;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import java.util.*;

public class Ex24a {

    public static int LIMIT_PRODUCT = 4; // limite de produtos iguais
    public static int TIME_SLOT = 20 * 1000; // em milissegundos (20 segundos)

    public static void main(String[] args) throws IOException {// Configurar a conexão com o MongoDB
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");

        // Acessar a base de dados
        MongoDatabase database = mongoClient.getDatabase("cbdex4");

        Scanner sc = new Scanner(System.in);
        FileWriter myWriter = new FileWriter("CBD-24a-out.txt");
        Timestamp currentTimestamp;
        String user, product;

        while (true) {
            System.out.println("Input 'user product': ");
            String input = sc.nextLine();
            if (input.isEmpty()) {
                break;
            }

            myWriter.write("Input 'user product': " + input + "\n");
            user = input.split(" ")[0];
            product = input.split(" ")[1];

            currentTimestamp = new Timestamp(System.currentTimeMillis());

            // verfificar se o user existe
            boolean userExists = false;
            for (String collectionName : database.listCollectionNames()) {
                if (collectionName.equals(user)) {
                    userExists = true;
                    break;
                }
            }

            if (userExists) {
                // Acessar a coleção "restaurantes"
                MongoCollection<Document> collection = database.getCollection(user);
                Map<String, String> existingProducts = jedis.hgetAll(user);

                int count = 0;
                for (String timestampStr : existingProducts.keySet()) {
                    long timestamp = Long.parseLong(timestampStr);
                    if (currentTimestamp.getTime() - timestamp <= TIME_SLOT) {
                        count++;
                    }
                }

                if (count > LIMIT_PRODUCT) {
                    System.out.println("!!! No more product of type " + product + " allowed. !!!\n");
                    myWriter.write("!!! No more product of type " + product + " allowed. !!!\n\n");
                } else {
                    // jedis.hset(user, String.valueOf(currentTimestamp.getTime()), product);
                    System.out.println(" - " + product + " added.\n");
                    myWriter.write(" - " + product + " added.\n\n");
                }
            } else {
                // se não, dar boas-vindas e introduzir normalmente no hash
                System.out.print("**Welcome, " + user + "!**");
                // jedis.hset(user, String.valueOf(currentTimestamp.getTime()), product);
                System.out.println(" - " + product + " added.\n");
                myWriter.write("**Welcome, " + user + "!**" + " - " + product + " added.\n\n");
            }

            System.out.println("--------------------");
            System.out.println(user + "'s inventary:" );
            myWriter.write("--------------------\n");
            myWriter.write(user + "'s inventary:\n" );
            // for (String key: jedis.hvals(user)) {
            //     System.out.println(key);
            //     myWriter.write(key.toString() + "\n");
            // }
            System.out.println("--------------------");
            myWriter.write("--------------------\n");
        }

        sc.close();
        myWriter.close();
    }
}


