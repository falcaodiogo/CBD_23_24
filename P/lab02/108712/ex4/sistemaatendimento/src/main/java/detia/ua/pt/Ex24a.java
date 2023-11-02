package detia.ua.pt;

import java.io.FileWriter;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Scanner;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

import org.bson.Document;

import java.util.Arrays;
import java.util.List;

public class Ex24a {

    public static int LIMIT_PRODUCT = 4; // limite de produtos iguais
    public static int TIME_SLOT = 20 * 1000; // em milissegundos (20 segundos)

    public static void main(String[] args) throws IOException {
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
        MongoDatabase database = mongoClient.getDatabase("cbdex4");
        MongoCollection<Document> existingProducts = database.getCollection("cbd");

        Scanner sc = new Scanner(System.in);
        FileWriter myWriter = new FileWriter("CBD_L204a-out_108712.txt");
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

            // Check if the user exists
            boolean userExists = existingProducts.find(Filters.eq("_id", user)).first() != null;

            if (userExists) {
                int count = 0;
                List<Document> products = existingProducts.find(Filters.eq("_id", user)).first().getList("products", Document.class);
                for (Document productDoc : products) {
                    long timestamp = productDoc.getLong("timestamp");
                    if (currentTimestamp.getTime() - timestamp <= TIME_SLOT) {
                        count++;
                    }
                }

                if (count > LIMIT_PRODUCT) {
                    System.out.println("!!! No more product of type " + product + " allowed. !!!\n");
                    myWriter.write("!!! No more product of type " + product + " allowed. !!!\n\n");
                } else {
                    // Add the product to the user's document
                    existingProducts.updateOne(Filters.eq("_id", user), new Document("$push", new Document("products", new Document("timestamp", currentTimestamp.getTime()).append("name", product))));
                    System.out.println(" - " + product + " added.\n");
                    myWriter.write(" - " + product + " added.\n\n");
                }
            } else {
                // If not, welcome the user and add the product
                System.out.print("**Welcome, " + user + "!**");
                Document newUserDocument = new Document("_id", user)
                        .append("products", Arrays.asList(new Document("timestamp", currentTimestamp.getTime()).append("name", product)));
                existingProducts.insertOne(newUserDocument);
                System.out.println(" - " + product + " added.\n");
                myWriter.write("**Welcome, " + user + "!**" + " - " + product + " added.\n\n");
            }

            System.out.println("--------------------");
            System.out.println(user + "'s inventory:");
            myWriter.write("--------------------\n");
            myWriter.write(user + "'s inventory:\n");
            Document userDoc = existingProducts.find(Filters.eq("_id", user)).first();
            if (userDoc != null) {
                List<Document> userProducts = userDoc.getList("products", Document.class);
                for (Document userProduct : userProducts) {
                    String productName = userProduct.getString("name");
                    System.out.println(productName);
                    myWriter.write(productName + "\n");
                }
            }
            System.out.println("--------------------");
            myWriter.write("--------------------\n");
        }

        sc.close();
        myWriter.close();
    }
}
