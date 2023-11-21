CREATE KEYSPACE ex3_2 WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 1};
USE ex3_2;
-- se valores são únicos, usar set, else, usar lista

--1 
DROP TABLE ex3_2.gestao_comentarios;
CREATE TABLE gestao_utilizadores(
   username varchar PRIMARY KEY,
   nome varchar,
   email varchar,
   selo_temporal timestamp
   );

--2
DROP TABLE ex3_2.gestao_videos;
CREATE TABLE gestao_videos(
   id_video int PRIMARY KEY,
   id_autor uuid,
   nome_video varchar,
   descricao_video varchar,
   tags set<varchar>,
   selo_temporal_video timestamp
);

--3
DROP TABLE ex3_2.gestao_comentarios;
CREATE TABLE gestao_comentarios(
   id_autor uuid,
   id_video int,
   comentario varchar,
   selo_temporal_comentario timestamp,
   PRIMARY KEY((id_autor), id_video)
);

--4
DROP TABLE ex3_2.gestao_video_followers;
CREATE TABLE gestao_video_followers(
   id_video int PRIMARY KEY,
   username set<varchar>,
);

--5
DROP TABLE ex3_2.registo_eventos;
CREATE TABLE registo_eventos(
   id_video int,
   id_autor int,
   tipo varchar, -- tem de ser play/pause/stop
   selo_temporal_registo timestamp,
   selo_temporal_video timestamp,
   PRIMARY KEY((id_video), id_autor),
);

--6
DROP TABLE ex3_2.rating_videos;
CREATE TABLE rating_videos(
   id_video int,
   valor int, 
   PRIMARY KEY((id_video), valor)
);

--7 
DROP TABLE ex3_2.pesquisa_autor;
CREATE TABLE pesquisa_autor(
   id_autor int,
   video set<varchar>, 
   selo_temporal_video timestamp,
   PRIMARY KEY((id_autor), selo_temporal_video)
);

--8 
DROP TABLE ex3_2.pesquisa_comentarios;
CREATE TABLE pesquisa_comentarios(
   id_video int,
   id_autor int,
   autor varchar,
   comentario varchar,
   data_stamp timestamp,
   PRIMARY KEY((autor), data_stamp), 
) WITH CLUSTERING ORDER BY (data_stamp DESC);

--9
DROP TABLE ex3_2.esquisa_video;
CREATE TABLE pesquisa_video(
   id_video int,
   id_comentario int,
   comentario varchar,
   data_stamp timestamp,
   PRIMARY KEY((id_video), data_stamp)
) WITH CLUSTERING ORDER BY (data_stamp DESC);

--10
SELECT avg(valor) FROM rating_videos;

-- ********************************* INSERTS **************************** 

-- CREATE TABLE gestao_utilizadores(
--    username varchar PRIMARY KEY,
--    nome varchar,
--    email varchar,
--    selo_temporal timestamp
--    );

INSERT INTO gestao_utilizadores (username, nome, email, selo_temporal)
VALUES (
   'falcao2.2',
   'Diogo Falcao',
   'falcao.diogo@ua.pt',
   '2020-01-01 10:10:10'
);
INSERT INTO gestao_utilizadores (username, nome, email, selo_temporal)
VALUES (
   'maria23',
   'Maria Silva',
   'maria.silva@example.com',
   '2020-01-02 11:11:11'
);
INSERT INTO gestao_utilizadores (username, nome, email, selo_temporal)
VALUES (
   'jose98',
   'José Santos',
   'jose.santos@teste.com',
   '2020-01-03 12:12:12'
);
INSERT INTO gestao_utilizadores (username, nome, email, selo_temporal)
VALUES (
   'ana_gomes',
   'Ana Gomes',
   'ana.gomes@exemplo.pt',
   '2020-01-04 13:13:13'
);
INSERT INTO gestao_utilizadores (username, nome, email, selo_temporal)
VALUES (
   'ricardo76',
   'Ricardo Fernandes',
   'ricardo.fernandes@example.pt',
   '2020-01-05 14:14:14'
);
INSERT INTO gestao_utilizadores (username, nome, email, selo_temporal)
VALUES (
   'carla_sousa',
   'Carla Sousa',
   'carla.sousa@teste.pt',
   '2020-01-06 15:15:15'
);
INSERT INTO gestao_utilizadores (username, nome, email, selo_temporal)
VALUES (
   'andre_costa',
   'André Costa',
   'andre.costa@exemplo.com',
   '2020-01-07 16:16:16'
);
INSERT INTO gestao_utilizadores (username, nome, email, selo_temporal)
VALUES (
   'sophia87',
   'Sofia Almeida',
   'sophia.almeida@example.pt',
   '2020-01-08 17:17:17'
);
INSERT INTO gestao_utilizadores (username, nome, email, selo_temporal)
VALUES (
   'joao91',
   'João Rodrigues',
   'joao.rodrigues@exemplo.pt',
   '2020-01-09 18:18:18'
);
INSERT INTO gestao_utilizadores (username, nome, email, selo_temporal)
VALUES (
   'beatriz04',
   'Beatriz Ferreira',
   'beatriz.ferreira@teste.com',
   '2020-01-10 19:19:19'
);

-- CREATE TABLE gestao_videos(
--    id_video int PRIMARY KEY,
--    id_autor varchar,
--    nome_video varchar,
--    descricao_video varchar,
--    tags set<varchar>,
--    selo_temporal_video timestamp
-- );

INSERT INTO gestao_videos (id_video, id_autor, nome_video, descricao_video, tags, selo_temporal_video)
VALUES (1, uuid(), 'Vídeo de Girafas', 'Descrição do Vídeo de Girafas', {'girafas', 'natureza'}, '2023-11-16 16:16:16');
INSERT INTO gestao_videos (id_video, id_autor, nome_video, descricao_video, tags, selo_temporal_video)
VALUES (2, uuid(), 'Macacos Engraçados', 'Descrição do Vídeo de Macacos Engraçados', {'macacos', 'humor'}, '2023-12-16 16:16:16');
INSERT INTO gestao_videos (id_video, id_autor, nome_video, descricao_video, tags, selo_temporal_video)
VALUES (3, uuid(), 'Vídeo de Golfinhos', 'Descrição do Vídeo de Golfinhos', {'golfinhos', 'mar'}, '2023-10-16 16:16:16');
INSERT INTO gestao_videos (id_video, id_autor, nome_video, descricao_video, tags, selo_temporal_video)
VALUES (4, uuid(), 'Vídeo de Cachorros', 'Descrição do Vídeo de Cachorros', {'cachorros', 'pets'}, '2023-11-16 16:16:16');
INSERT INTO gestao_videos (id_video, id_autor, nome_video, descricao_video, tags, selo_temporal_video)
VALUES (5, uuid(), 'Vídeo de Gatos', 'Descrição do Vídeo de Gatos', {'gatos', 'pets'}, '2023-11-16 16:16:16');
INSERT INTO gestao_videos (id_video, id_autor, nome_video, descricao_video, tags, selo_temporal_video)
VALUES (6, uuid(), 'Vídeo de Pássaros', 'Descrição do Vídeo de Pássaros', {'pássaros', 'natureza'}, '2023-10-16 16:16:16');
INSERT INTO gestao_videos (id_video, id_autor, nome_video, descricao_video, tags, selo_temporal_video)
VALUES (7, uuid(), 'Vídeo de Elefantes', 'Descrição do Vídeo de Elefantes', {'elefantes', 'natureza'}, '2023-10-16 16:16:16');
INSERT INTO gestao_videos (id_video, id_autor, nome_video, descricao_video, tags, selo_temporal_video)
VALUES (8, uuid(), 'Vídeo de Serpentes', 'Descrição do Vídeo de Serpentes', {'serpentes', 'natureza'}, '2023-11-16 16:16:16');
INSERT INTO gestao_videos (id_video, id_autor, nome_video, descricao_video, tags, selo_temporal_video)
VALUES (9, uuid(), 'Vídeo de Leões', 'Descrição do Vídeo de Leões', {'leões', 'natureza'}, '2023-11-16 16:16:16');
INSERT INTO gestao_videos (id_video, id_autor, nome_video, descricao_video, tags, selo_temporal_video)
VALUES (10, uuid(), 'Vídeo de Tigres', 'Descrição do Vídeo de Tigres', {'tigres', 'natureza'}, '2023-11-16 16:16:16');

-- CREATE TABLE gestao_comentarios(
--    id_autor uuid,
--    id_video int,
--    comentario varchar,
--    selo_temporal_comentario timestamp,
--    PRIMARY KEY((id_autor), id_video)
-- );

INSERT INTO gestao_comentarios(id_autor, id_video, comentario, selo_temporal_comentario)
VALUES (864103bc-bcfc-4112-bb7c-059dabf4f641, 10, 'Wow so amazing. I love monkeys!', '2023-11-16 16:20:12');
INSERT INTO gestao_comentarios(id_autor, id_video, comentario, selo_temporal_comentario)
VALUES (f96cd471-f02e-4fa8-9973-4f647de7c458, 5, 'Gatos são melhores que cães, periodt...', '2023-12-16 19:20:12');
INSERT INTO gestao_comentarios(id_autor, id_video, comentario, selo_temporal_comentario)
VALUES (3d389c22-86e6-4890-b9cf-bb80fd1f5e37, 1, 'Não entendo o pescoço delas', '2023-12-16 19:20:12');
INSERT INTO gestao_comentarios(id_autor, id_video, comentario, selo_temporal_comentario)
VALUES (7a10c3d5-8635-4301-b2e1-f5c59d1b0ad1, 8, 'ewww serpentes', '2023-12-16 19:20:12');
INSERT INTO gestao_comentarios(id_autor, id_video, comentario, selo_temporal_comentario)
VALUES (fc509e6f-0a60-4787-98d3-74fb82b5da20, 2, 'you monkey', '2023-12-16 19:20:12');
INSERT INTO gestao_comentarios(id_autor, id_video, comentario, selo_temporal_comentario)
VALUES (42e7ae6a-0577-4e3c-b4c8-95b62c48fea3, 4, 'Ohhh cute', '2023-12-16 19:20:12');
INSERT INTO gestao_comentarios(id_autor, id_video, comentario, selo_temporal_comentario)
VALUES (42e7ae6a-0577-4e3c-b4c8-95b62c48fea3, 4, 'Gatos são melhores que cães, periodt...', '2023-12-16 19:20:12');
INSERT INTO gestao_comentarios(id_autor, id_video, comentario, selo_temporal_comentario)
VALUES (42e7ae6a-0577-4e3c-b4c8-95b62c48fea3, 4, 'Coisa feia', '2023-12-16 19:20:12');
INSERT INTO gestao_comentarios(id_autor, id_video, comentario, selo_temporal_comentario)
VALUES (42e7ae6a-0577-4e3c-b4c8-95b62c48fea3, 4, 'Isso ou uma batata servem para o mesmo', '2023-12-16 19:20:12');
INSERT INTO gestao_comentarios(id_autor, id_video, comentario, selo_temporal_comentario)
VALUES (5c6efb3f-eab1-43da-8fa3-e0b7faf6e67e, 9, 'Raurrrr', '2023-12-16 19:20:12');
INSERT INTO gestao_comentarios(id_autor, id_video, comentario, selo_temporal_comentario)
VALUES (f96cd471-f02e-4fa8-9973-4f647de7c458, 5, 'Ohhhh gatos', '2023-12-16 19:20:12');
INSERT INTO gestao_comentarios(id_autor, id_video, comentario, selo_temporal_comentario)
VALUES (44b7fbc0-1d46-40e6-bdc2-1956b6dc5386, 3, 'Hihihihi', '2023-12-16 19:20:12');

-- DROP TABLE ex3_2.gestao_video_followers;
-- CREATE TABLE gestao_video_followers(
--    id_video int PRIMARY KEY,
--    username set<varchar>,
-- );

INSERT INTO gestao_video_followers(id_video, username)
VALUES (10, {'carla_sousa', 'falcao2.2'});
INSERT INTO gestao_video_followers(id_video, username)
VALUES (8, {'maria23'});
INSERT INTO gestao_video_followers(id_video, username)
VALUES (3, {'andre_costa', 'ana_gomes', 'sophia87'});
INSERT INTO gestao_video_followers(id_video, username)
VALUES (9, {'andre_costa', 'ana_gomes', 'sophia87'});
INSERT INTO gestao_video_followers(id_video, username)
VALUES (4, {'andre_costa', 'joao91', 'jose98', 'joao91'});
INSERT INTO gestao_video_followers(id_video, username)
VALUES (7, {'andre_costa', 'joao91', 'jose98', 'joao91'});
INSERT INTO gestao_video_followers(id_video, username)
VALUES (2, {'andre_costa', 'joao91', 'jose98', 'joao91'});

--DROP TABLE ex3_2.registo_eventos;
-- CREATE TABLE registo_eventos(
--    id_video int,
--    id_autor uuid,
--    tipo varchar, -- tem de ser play/pause/stop
--    selo_temporal_registo timestamp,
--    selo_temporal_video timestamp,
--    PRIMARY KEY((id_video), id_autor),
-- );

INSERT INTO registo_eventos(id_video, id_autor, tipo, selo_temporal_registo, selo_temporal_video)
VALUES (1, 3d389c22-86e6-4890-b9cf-bb80fd1f5e37, 'play', '2023-12-16 16:16:16', '2023-12-18 16:16:16');
INSERT INTO registo_eventos(id_video, id_autor, tipo, selo_temporal_registo, selo_temporal_video)
VALUES (4, 42e7ae6a-0577-4e3c-b4c8-95b62c48fea3, 'pause', '2023-12-16 16:16:16', '2023-12-18 16:16:16');
INSERT INTO registo_eventos(id_video, id_autor, tipo, selo_temporal_registo, selo_temporal_video)
VALUES (5, f96cd471-f02e-4fa8-9973-4f647de7c458, 'play', '2023-12-16 16:16:16', '2023-12-18 16:16:16');
INSERT INTO registo_eventos(id_video, id_autor, tipo, selo_temporal_registo, selo_temporal_video)
VALUES (8, 7a10c3d5-8635-4301-b2e1-f5c59d1b0ad1, 'play', '2023-12-16 16:16:16', '2023-12-18 16:16:16');
INSERT INTO registo_eventos(id_video, id_autor, tipo, selo_temporal_registo, selo_temporal_video)
VALUES (10, 864103bc-bcfc-4112-bb7c-059dabf4f641, 'stop', '2023-12-16 16:16:16', '2023-12-18 16:16:16');
INSERT INTO registo_eventos(id_video, id_autor, tipo, selo_temporal_registo, selo_temporal_video)
VALUES (9, 5c6efb3f-eab1-43da-8fa3-e0b7faf6e67e, 'pause', '2023-12-16 16:16:16', '2023-12-18 16:16:16');
INSERT INTO registo_eventos(id_video, id_autor, tipo, selo_temporal_registo, selo_temporal_video)
VALUES (2, fc509e6f-0a60-4787-98d3-74fb82b5da20, 'stop', '2023-12-16 16:16:16', '2023-12-18 16:16:16');

-- DROP TABLE ex3_2.rating_videos;
-- CREATE TABLE rating_videos(
--    id_video int,
--    valor int, 
--    PRIMARY KEY((id_video), valor)
-- );