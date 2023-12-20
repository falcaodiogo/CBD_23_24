package pt.ua.cbd.lab4.ex4;

import org.neo4j.driver.*;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Neo4jCSVLoader {

    public static void main(String[] args) {
        String uri = "bolt://localhost:7687";
        String username = "user";
        String password = "pass";

        try (Driver driver = GraphDatabase.driver(uri, AuthTokens.basic(username, password));
             Session session = driver.session()) {

            String csvFilePath = "/home/diogof/Desktop/CBD-23_24/P/lab4_template/resources/archive/spotify-2023.csv";

            BufferedReader br = new BufferedReader(new FileReader(csvFilePath));
            br.readLine();
            String line;
            while ((line = br.readLine()) != null) {
                String[] data = line.split(",");

                String cypherQuery = 
                        "MERGE (m:Music {name: $name, year: $year, month: $month, day: $day, bpm: $bpm, key: $key, mode: $mode}) " +
                        "MERGE (a:Artist {name2: $name2, count: $count}) " +
                        "MERGE (p:StreamsAndPlaylists {spotify: $spotify, streams: $streams, apple: $apple, deezerplaylist: $deezerplaylist, shazam: $shazam}) " +
                        "MERGE (m)-[:IS_FROM]-(a) " +
                        "MERGE (m)-[:HAS_STREAMS]-(p) " +
                        "MERGE (a)-[:HAS_STREAMS]-(p)";

                session.run(cypherQuery, Values.parameters(
                        "name",data[0],
                        "year", data[3],
                        "month", data[4],
                        "day", data[5],
                        "bpm", data[14],
                        "key", data[15],
                        "name2", data[1],
                        "mode", data[16],
                        "count", data[2],
                        "spotify", data[6],
                        "streams", data[8],
                        "apple", data[10],
                        "deezerplaylist", data[12],
                        "shazam", data[13]
                ));
            }
            br.close(); // Moved outside the while loop
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

