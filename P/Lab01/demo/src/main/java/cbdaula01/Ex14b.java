package cbdaula01;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import redis.clients.jedis.Jedis;

public class Ex14b {

    public static void main(String[] args) throws IOException {

        File file = new File("P/Lab01/nomes-pt-2021.csv");
        Scanner sc = new Scanner(System.in);
        Jedis jedis = new Jedis();
        try (FileWriter myWriter = new FileWriter("CBD-14b-out.txt")) {
            List <String> names = new ArrayList<>();

            try (Scanner input = new Scanner(file)) {

                while (input.hasNextLine()) {
                    String[] infoo = input.nextLine().split(";");
                    String name_info = infoo[0]; // name
                    Integer rank_info = Integer.parseInt(infoo[1]); // rank
                    jedis.zadd("names", rank_info, name_info); // automaticamente ordenado
                }

                while (true) {
                    System.out.println("Search for (Press Enter to quit): ");
                    String name = sc.nextLine();
                    if (name.isEmpty()) {
                        break; 
                    }

                    names = jedis.zrevrange("names", 0, -1);

                    myWriter.write("Search for (Press Enter to quit): " + name + "\n");

                    for(String word: names) {
                        if (word.startsWith(name)) {
                            System.out.println(word);
                            myWriter.write(word + "\n");
                        }
                    }

                }

            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        sc.close();
        jedis.close();
        
    }
    
}
