package cbdaula01;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import redis.clients.jedis.Jedis; 
  
public class SimplePost { 
    public static String USERS_KEY = "users"; // Key set for users' name 
    public static String USERS_KEY_LIST = "usersList";
    public static String USERS_KEY_HASH = "usersHash";
  
    public static void main(String[] args) { 
        Jedis jedis = new Jedis(); 
        // some users 
        String[] users = { "Ana", "Pedro", "Maria", "Luis" };
        // jedis.del(USERS_KEY); // remove if exists to avoid wrong type 
        for (String user : users)  
            jedis.sadd(USERS_KEY, user); 
        jedis.smembers(USERS_KEY).forEach(System.out::println); 

        // jedis.flushAll();

        // lista
        List <String> users_list = new ArrayList<>();
        users_list.add("Ana");
        users_list.add("Pedro");
        users_list.add("Maria");
        users_list.add("Luís");
        // input to list
        for (String user: users_list) {
            jedis.rpush(USERS_KEY_LIST, user);
        }
        // print
        System.out.println(jedis.lrange(USERS_KEY_LIST, 0, -1));

        // jedis.flushAll();

        HashMap<String, Integer> users_hash = new HashMap<String, Integer>();
        users_hash.put("Ana", 0);
        users_hash.put("Pedro", 1);
        users_hash.put("Maria", 2);
        users_hash.put("Luís", 3);
        // input to hash map:
        for (String name : users_hash.keySet()) {
            jedis.hincrBy(USERS_KEY_HASH, name, users_hash.get(name));
        }
        //print
        System.out.println(jedis.hgetAll(USERS_KEY_HASH));

        jedis.close();

    } 
}