CREATE KEYSPACE ex3_2 WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 1};

--1
CREATE TABLE gestao_utilizadores(
   username text PRIMARY KEY,
   nome text,
   email text,
   selo_temporal timestamp
   );

--2
CREATE TABLE gestao_videos(
   id int PRIMARY KEY,
   autor text,
   nome_video text,
   descricao_video text,
   tags set<text>,
   selo_temporal_video timestamp
);

--3
CREATE TABLE gestao_comentarios(
   id int PRIMARY KEY,
   id_video int,
   comentario text,
   selo_temporal_comentario timestamp
);

--4
CREATE TABLE gestao_video_followers(
   id_video int PRIMARY KEY,
   users set<text>,
);

--5
CREATE TABLE registo_eventos(
   id_video int,
   id_autor int,
   tipo text, -- tem de ser play/pause/stop
   selo_temporal_registo timestamp,
   selo_temporal_video timestamp,
   PRIMARY KEY((id_video), id_autor),
);

--6
CREATE TABLE rating_videos(
   id int PRIMARY KEY,
   valor int, 
);

--7 NÃO DEU!!!
CREATE TABLE pesquisa_autor(
   id_video int,
   id_autor int,
   video set<text>, -- ??? com sets ou basta só video text
   PRIMARY KEY((id_video), id_autor)
);

--8 
CREATE TABLE pesquisa_comentarios(
   id_video int,
   id_autor int,
   autor text,
   comentario text,
   data_stamp timestamp,
   PRIMARY KEY((id_video), id_autor), --???
) WITH CLUSTERING ORDER BY (data_stamp DESC);

--9
CREATE TABLE pesquisa_video(
   id_video int,
   id_comentario int,
   comentario text,
   data_stamp timestamp,
   PRIMARY KEY((id_video), data_stamp)
) WITH CLUSTERING ORDER BY (data_stamp DESC);

--10
SELECT avg(valor) FROM rating_videos;