package cbdaula01;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.Scanner;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.params.ZParams;
import redis.clients.jedis.resps.Tuple;

public class Ex14b {

    public static String USERS = "users1"; 
    public static String USERS_RANKED = "users2";
    public static String RESULT = "users3";
    public static String USERS_2 = "users4";

    public static void main(String[] args) throws IOException {

        File file = new File("nomes-pt-2021.csv");
        Scanner sc = new Scanner(System.in);
        Jedis jedis = new Jedis();
        FileWriter myWriter = new FileWriter("CBD-14b-out.txt");

        jedis.flushAll();

        try (Scanner input = new Scanner(file)) {

            while (input.hasNextLine()) {
                String[] info = input.nextLine().split(";");
                String name_info = info[0].toLowerCase(); // Nome
                Double rank_info = Double.parseDouble(info[1]); // Rank
                jedis.zadd(USERS, 0, name_info); // ranks iguais entre todos
                jedis.zadd(USERS_RANKED, rank_info, name_info); // ranks diferentes
            }

            while (true) {
                System.out.println("Pesquisar por (Pressione Enter para sair): ");
                String name = sc.nextLine();
                if (name.isEmpty()) {
                    break; 
                }

                name = name.toLowerCase();              
                myWriter.write("Pesquisar por (Pressione Enter para sair): " + name + "\n");

                jedis.del(USERS_2);

                for (String s: jedis.zrangeByLex(USERS, "[" + name, "(" + name + "~")) {
                    jedis.zadd(USERS_2, jedis.zrem(USERS, s), s);
                    // System.out.println(s + ", rank: " + jedis.zrem(USERS, s));
                }

                ZParams params = new ZParams().weights(0, 1);
                jedis.zinterstore(RESULT, params, USERS_2, USERS_RANKED);

            
                List<Tuple> resultSet = jedis.zrangeWithScores(RESULT, 0, -1);
                for (Tuple tuple : resultSet) {
                    String name2 = tuple.getElement();
                    double number = tuple.getScore();
                    System.out.println(name2 + ", rank: " + number);
                    myWriter.write(name2 + ", rank: " + number + "\n");
                }


            }
        } catch (FileNotFoundException e) {
            System.err.println(e.getMessage());
        } finally {
            sc.close();
            jedis.close();
            myWriter.close();
        }
    }
}
