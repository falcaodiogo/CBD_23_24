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

public class Ex24b {

    public static int LIMIT_UNITS = 10; // limite total de unidades de produto permitidas
    public static int TIME_SLOT = 20 * 1000; // em milissegundos (20 segundos)

    public static void main(String[] args) throws IOException {
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
        MongoDatabase database = mongoClient.getDatabase("cbdex4");
        MongoCollection<Document> existingProducts = database.getCollection("cbd2");

        Scanner sc = new Scanner(System.in);
        FileWriter myWriter = new FileWriter("CBD_L204b-out_108712.txt");
        Timestamp currentTimestamp;
        String user, product;
        int quantity;

        while (true) {
            System.out.println("Input 'user product quantity': ");
            String input = sc.nextLine();
            if (input.isEmpty()) {
                break;
            }

            myWriter.write("Input 'user product quantity': " + input + "\n");
            String[] inputParts = input.split(" ");
            user = inputParts[0];
            product = inputParts[1];
            quantity = Integer.parseInt(inputParts[2]);

            currentTimestamp = new Timestamp(System.currentTimeMillis());

            // Check if the user exists
            boolean userExists = existingProducts.find(Filters.eq("_id", user)).first() != null;

            if (userExists) {
                int totalUnits = 0;
                List<Document> products = existingProducts.find(Filters.eq("_id", user)).first().getList("products", Document.class);
                for (Document productDoc : products) {
                    long timestamp = productDoc.getLong("timestamp");
                    if (currentTimestamp.getTime() - timestamp <= TIME_SLOT) {
                        totalUnits += productDoc.getInteger("quantity");
                    }
                }

                if (totalUnits + quantity > LIMIT_UNITS) {
                    System.out.println("!!! No more units of type " + product + " allowed. !!!\n");
                    myWriter.write("!!! No more units of type " + product + " allowed. !!!\n\n");
                } else {
                    // Add the product with quantity to the user's document
                    existingProducts.updateOne(Filters.eq("_id", user), new Document("$push", new Document("products", new Document("timestamp", currentTimestamp.getTime()).append("name", product).append("quantity", quantity))));
                    System.out.println(" - " + quantity + " units of " + product + " added.\n");
                    myWriter.write(" - " + quantity + " units of " + product + " added.\n\n");
                }
            } else {
                // If not, welcome the user and add the product with quantity
                System.out.print("**Welcome, " + user + "!**");
                Document newUserDocument = new Document("_id", user)
                        .append("products", Arrays.asList(new Document("timestamp", currentTimestamp.getTime()).append("name", product).append("quantity", quantity)));
                existingProducts.insertOne(newUserDocument);
                System.out.println(" - " + quantity + " units of " + product + " added.\n");
                myWriter.write("**Welcome, " + user + "!**" + " - " + quantity + " units of " + product + " added.\n\n");
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
                    int productQuantity = userProduct.getInteger("quantity");
                    System.out.println(productName + " - " + productQuantity + " units");
                    myWriter.write(productName + " - " + productQuantity + " units\n");
                }
            }
            System.out.println("--------------------");
            myWriter.write("--------------------\n");
        }

        sc.close();
        myWriter.close();
    }
}

