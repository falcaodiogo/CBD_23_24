package ua.deti.pt;

import java.io.FileWriter;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Map;
import java.util.Scanner;
import redis.clients.jedis.Jedis;

public class Ex15a {

    public static int LIMIT_PRODUCT = 4; // limite de produtos iguais
    public static int TIME_SLOT = 20 * 1000; // em milissegundos (20 segundos)

    public static void main(String[] args) throws IOException {
        Jedis jedis = new Jedis();
        Scanner sc = new Scanner(System.in);
        FileWriter myWriter = new FileWriter("CBD-15a-out.txt");
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
            if (!jedis.exists(user)) {
                // se não, dar boas-vindas e introduzir normalmente no hash
                System.out.print("**Welcome, " + user + "!**");
                jedis.hset(user, String.valueOf(currentTimestamp.getTime()), product);
                System.out.println(" - " + product + " added.\n");
                myWriter.write("**Welcome, " + user + "!**" + " - " + product + " added.\n\n");
            } else {
                /*  caso o user já exista, percorrer os keys, values.
                        se o tempo estiver dentro do time slot, conta até chegar ao limite de produtos/tempo 
                        se o tempo estiver fora do time slot, não deixa introduzir mais até o intervalo de tempo for reposto */
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
                    jedis.hset(user, String.valueOf(currentTimestamp.getTime()), product);
                    System.out.println(" - " + product + " added.\n");
                    myWriter.write(" - " + product + " added.\n\n");
                }
            }

            System.out.println("--------------------");
            System.out.println(user + "'s inventary:" );
            myWriter.write("--------------------\n");
            myWriter.write(user + "'s inventary:\n" );
            for (String key: jedis.hvals(user)) {
                System.out.println(key);
                myWriter.write(key.toString() + "\n");
            }
            System.out.println("--------------------");
            myWriter.write("--------------------\n");
        }

        jedis.flushAll();
        sc.close();
        jedis.close();
        myWriter.close();
    }
}

