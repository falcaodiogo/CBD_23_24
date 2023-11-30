package pt.ua.cbd.lab3.ex3;

import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;

public class App 
{
    public static void main(String[] args) {
        try(CqlSession session = CqlSession.builder().build()) {

            ResultSet rs = session.execute("select release_version from system.local");
            Row row = rs.one();
            System.out.println(row.getString("release_version"));

            session.execute("use ex3_2;");
            session.execute("INSERT INTO ex3_2.gestao_utilizadores (username, nome, email, selo_temporal) VALUES ('inteligencil_artificial','Inter','interaleppo@ua.pt','2023-09-09 11:10:10');");       
                    
            session.execute("UPDATE ex3_2.gestao_utilizadores SET nome = 'inteligencial' WHERE username = 'inteligenci_artificial';");

            session.execute("SELECT * FROM gestao_comentarios WHERE id_autor = 864103bc-bcfc-4112-bb7c-059dabf4f641 ORDER BY id_video DESC;");

            // d) 2)
            session.execute("SELECT tags FROM gestao_videos WHERE id_video = 2;");

            // d) 7)
            session.execute("SELECT * FROM gestao_video_followers WHERE id_video = 10;");

            // d) 11)
            session.execute("SELECT tags FROM gestao_videos;");

            // d) 13)
            session.execute("SELECT * FROM gestao_comentarios WHERE comentario = 'Isso ou uma batata servem para o mesmo';");
        }
    }

}