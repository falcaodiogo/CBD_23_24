package cbdaula01;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;
import redis.clients.jedis.Jedis;

public class Ex14a {

    public static String USERS = "users"; // Key set for users' name 

    public static void main(String[] args) throws IOException {
        File file = new File("P/Lab01/names.txt");
        Scanner sc = new Scanner(System.in);
        Jedis jedis = new Jedis();
        FileWriter myWriter = new FileWriter("CBD-14a-out.txt");
        int count = 0;

        try (Scanner input = new Scanner(file)) {
            
            while (true) {
                System.out.print("Search for (Press Enter to quit): ");
                String name = sc.nextLine();
                if (name.isEmpty()) {
                    break; 
                }

                name = name.toLowerCase();

                myWriter.write("Search for (Press Enter to quit): " + name + "\n");

                while (input.hasNext()) {
                    String word = input.next();
                    jedis.zadd(USERS, count, word);
                    count++;
                }

                System.out.println(jedis.zrangeByLex(USERS, "[" + name, "(" + name + "~"));
    
                // jedis.flushAll();
    
            }
        } catch (FileNotFoundException e) {
            System.err.println("File not found: " + e.getMessage());
        } 
        
        myWriter.close();
        jedis.close();
        sc.close();
    }
}