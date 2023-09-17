package cbdaula01;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.Scanner;
import redis.clients.jedis.Jedis;

public class Ex14a {

    public static void main(String[] args) throws IOException {
        File file = new File("/home/diogofalcao/Desktop/CBD/P/Lab01/names.txt");
        Scanner sc = new Scanner(System.in);
        Jedis jedis = new Jedis();
        FileWriter myWriter = new FileWriter("CBD-14a-out.txt");

        try (Scanner input = new Scanner(file)) {
            while (true) {
                System.out.print("Search for (Press Enter to quit): ");
                String name = sc.nextLine();
                if (name.isEmpty()) {
                    break; 
                }

                myWriter.write("Search for (Press Enter to quit): " + name + "\n");
                // jedis.del("lista"); 

                while (input.hasNext()) {
                    String word = input.next();
                    jedis.rpush("lista", word); 
                }

                List<String> words = jedis.lrange("lista", 0, -1);

                for (String word : words) {
                    if (word.startsWith(name)) {
                        System.out.println(word);
                        myWriter.write(word + "\n");
                    }
                }
    
            }
        } catch (FileNotFoundException e) {
            System.err.println("File not found: " + e.getMessage());
        } 
        
        myWriter.close();
        jedis.close();
        sc.close();
    }
}


// Numa primeira iteração, tentei usar uma arraylist para colocar todas as pelavras do .txt
// No entanto, estaria apenas a usar o jedis para fazer um rpush e nunca mais o usava
// Desta forma passei todas as palavras no jedis para uma lista com um lrange

// Durante o desenvolvimento do exercício usei o jedis.del ocasionalmente porque o output não estava correto, mas na última iteração já não foi preciso usar