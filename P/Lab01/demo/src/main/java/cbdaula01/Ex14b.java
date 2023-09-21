package cbdaula01;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;

import redis.clients.jedis.Jedis;

public class Ex14b {

    public static String USERS = "users2"; // Key set for users' name 

    public static void main(String[] args) throws IOException {

        File file = new File("P/Lab01/names.txt");
        Scanner sc = new Scanner(System.in);
        Jedis jedis = new Jedis();
        FileWriter myWriter = new FileWriter("CBD-14b-out.txt");

        try (Scanner input = new Scanner(file)) {

            while (true) {
                System.out.println("Search for (Press Enter to quit): ");
                String name = sc.nextLine();
                if (name.isEmpty()) {
                    break; 
                }

            name = name.toLowerCase();              

            myWriter.write("Search for (Press Enter to quit): " + name + "\n");

            while (input.hasNextLine()) {
                String[] infoo = input.nextLine().split(";");
                String name_info = infoo[0]; // name
                Integer rank_info = Integer.parseInt(infoo[1]); // rank
                jedis.zadd(USERS, rank_info, name_info); // automaticamente ordenado
            }

                System.out.println(jedis.zrangeByLex(USERS, "[" + name, "(" + name + "~"));
            }

        } catch (FileNotFoundException e) {
            System.err.println("File not found: " + e.getMessage());
        } 
        

        sc.close();
        jedis.close();
        
    }
    
}
