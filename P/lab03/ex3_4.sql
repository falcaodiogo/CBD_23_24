CREATE KEYSPACE ex3_4 WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 1};
USE ex3_4;

-- BD sobre comboios da CP
DROP TABLE ex3_4.comboio;
CREATE TABLE IF NOT EXISTS comboio(
    numero_comboio uuid,
    tipo_comboio varchar,
    velocidade int, 
    lugares int,
    carruagens list<int>,
    PRIMARY KEY((numero_comboio), tipo_comboio),
);

DROP TABLE ex3_4.viagens;
CREATE TABLE IF NOT EXISTS viagens (
    viagem_id uuid,
    numero_comboio uuid,
    partida timestamp,
    chegada timestamp,
    estacoes set<varchar>,
    n_pessoas_por_carruagem map<int,int>,
    PRIMARY KEY((viagem_id), numero_comboio)
);

DROP TABLE ex3_4.atrasos;
CREATE TABLE IF NOT EXISTS atrasos (
    atraso_id uuid,
    viagem_id uuid,
    duracao_atraso int,
    razao_atraso text,
    PRIMARY KEY((atraso_id), viagem_id),
);

DROP TABLE IF EXISTS ex3_4.passageiro;
CREATE TABLE IF NOT EXISTS ex3_4.passageiro (
   passageiro_id uuid,
   passageiro_name text,
   passageiro_age int,
   viagem_id uuid,
   numero_comboio int,
   PRIMARY KEY((passageiro_id), viagem_id),
);


INSERT INTO comboio (numero_comboio, tipo_comboio, velocidade, lugares, carruagens)
VALUES (a07113b2-1bb8-452b-96f3-f73c3f1cb2fe, 'Alfa', 220, 400, [1, 2, 3]);
INSERT INTO comboio (numero_comboio, tipo_comboio, velocidade, lugares, carruagens)
VALUES (35df08b1-a7fa-4222-9c4d-5ad30760dcb2, 'Alfa', 220, 400, [1, 2, 3, 4]);
INSERT INTO comboio (numero_comboio, tipo_comboio, velocidade, lugares, carruagens)
VALUES (35cf310a-ac8e-4117-a4f1-a06a3bf598a0, 'Alfa', 220, 400, [1, 2, 3, 4]);
INSERT INTO comboio (numero_comboio, tipo_comboio, velocidade, lugares, carruagens)
VALUES (0d2d4ce1-9cb9-4ea4-9993-8e2c108c4252, 'Urbano', 100, 600, [1, 2, 3, 4, 5, 6]);
INSERT INTO comboio (numero_comboio, tipo_comboio, velocidade, lugares, carruagens)
VALUES (52b17de1-01a0-41dd-8f6b-80854b237223, 'Urbano', 100, 800, [1, 2, 3, 4, 5, 6, 7]);
INSERT INTO comboio (numero_comboio, tipo_comboio, velocidade, lugares, carruagens)
VALUES (0ff34aec-a82d-45c8-a4e7-ec4d2f6fa533, 'Regional', 150, 230, [1, 2, 3, 4]);
INSERT INTO comboio (numero_comboio, tipo_comboio, velocidade, lugares, carruagens)
VALUES (8befddd5-7f9b-47a7-ba77-e5ef712ccb0f, 'Regional', 150, 230, [1, 2, 3, 4]);
INSERT INTO comboio (numero_comboio, tipo_comboio, velocidade, lugares, carruagens)
VALUES (ae7dfd2d-8b9a-4f8b-b22f-a45556c4e42e, 'Regional', 150, 290, [1, 2, 3, 4, 5]);
INSERT INTO comboio (numero_comboio, tipo_comboio, velocidade, lugares, carruagens)
VALUES (7b21abd0-2840-499a-a8b2-588adfd2c86b, 'IC', 180, 400, [1, 2, 3, 4]);
INSERT INTO comboio (numero_comboio, tipo_comboio, velocidade, lugares, carruagens)
VALUES (404ee77d-b7b2-42f0-8cc4-11f36885b309, 'IC', 180, 400, [1, 2, 3, 4]);
INSERT INTO comboio (numero_comboio, tipo_comboio, velocidade, lugares, carruagens)
VALUES (6c6c1722-6004-411c-867d-28479dcbfc4a, 'IC', 180, 400, [1, 2, 3, 4]);
INSERT INTO comboio (numero_comboio, tipo_comboio, velocidade, lugares, carruagens)
VALUES (00f7eb86-a65d-4717-836b-de98e037f2e0, 'IC', 180, 400, [1, 2, 3, 4]);

--  a07113b2-1bb8-452b-96f3-f73c3f1cb2fe |         Alfa |             [1, 2, 3] |     400 |        220
--  7b21abd0-2840-499a-a8b2-588adfd2c86b |           IC |          [1, 2, 3, 4] |     400 |        180
--  ae7dfd2d-8b9a-4f8b-b22f-a45556c4e42e |     Regional |       [1, 2, 3, 4, 5] |     290 |        150
--  35df08b1-a7fa-4222-9c4d-5ad30760dcb2 |         Alfa |          [1, 2, 3, 4] |     400 |        220
--  0ff34aec-a82d-45c8-a4e7-ec4d2f6fa533 |     Regional |          [1, 2, 3, 4] |     230 |        150
--  52b17de1-01a0-41dd-8f6b-80854b237223 |       Urbano | [1, 2, 3, 4, 5, 6, 7] |     800 |        100
--  404ee77d-b7b2-42f0-8cc4-11f36885b309 |           IC |          [1, 2, 3, 4] |     400 |        180
--  6c6c1722-6004-411c-867d-28479dcbfc4a |           IC |          [1, 2, 3, 4] |     400 |        180
--  8befddd5-7f9b-47a7-ba77-e5ef712ccb0f |     Regional |          [1, 2, 3, 4] |     230 |        150
--  0d2d4ce1-9cb9-4ea4-9993-8e2c108c4252 |       Urbano |    [1, 2, 3, 4, 5, 6] |     600 |        100
--  35cf310a-ac8e-4117-a4f1-a06a3bf598a0 |         Alfa |          [1, 2, 3, 4] |     400 |        220
--  00f7eb86-a65d-4717-836b-de98e037f2e0 ect

INSERT INTO viagens (viagem_id, numero_comboio, partida, chegada, estacoes, n_pessoas_por_carruagem)
VALUES (uuid(), a07113b2-1bb8-452b-96f3-f73c3f1cb2fe, '2020-01-06 15:15:15', '2020-01-06 17:15:15', {'Porto', 'Coimbra', 'Aveiro', 'Lisboa'}, {1: 50, 2: 45, 3: 48});
INSERT INTO viagens (viagem_id, numero_comboio, partida, chegada, estacoes, n_pessoas_por_carruagem)
VALUES (uuid(), 7b21abd0-2840-499a-a8b2-588adfd2c86b, '2020-01-06 16:15:15', '2020-01-06 18:15:15', {'Porto', 'Ovar', 'Coimbra', 'Pombal', 'Aveiro', 'Lisboa'}, {21: 50, 22: 45, 23: 48, 81:40});
INSERT INTO viagens (viagem_id, numero_comboio, partida, chegada, estacoes, n_pessoas_por_carruagem)
VALUES (uuid(), ae7dfd2d-8b9a-4f8b-b22f-a45556c4e42e, '2020-01-06 17:15:15', '2020-01-06 19:15:15', {'Castelo Branco', 'Tinalhas', 'Alcains'}, {1: 50, 2: 45, 3: 48, 4:0, 5:0});
INSERT INTO viagens (viagem_id, numero_comboio, partida, chegada, estacoes, n_pessoas_por_carruagem)
VALUES (uuid(), 35df08b1-a7fa-4222-9c4d-5ad30760dcb2, '2020-01-06 16:15:15', '2020-01-06 18:15:15', {'Porto', 'Coimbra', 'Aveiro', 'Lisboa'}, {1: 50, 2: 45, 3: 48});
INSERT INTO viagens (viagem_id, numero_comboio, partida, chegada, estacoes, n_pessoas_por_carruagem)
VALUES (uuid(), 0ff34aec-a82d-45c8-a4e7-ec4d2f6fa533, '2020-01-06 15:15:15', '2020-01-06 17:15:15', {'Castelo Branco', 'Tinalhas', 'Alcains'}, {1: 50, 2: 45, 3: 48, 4:90});
INSERT INTO viagens (viagem_id, numero_comboio, partida, chegada, estacoes, n_pessoas_por_carruagem)
VALUES (uuid(), 52b17de1-01a0-41dd-8f6b-80854b237223, '2020-01-06 14:15:15', '2020-01-06 15:15:15', {'Aveiro, Lousa, Freixial'}, {1: 50, 2: 45, 3: 48, 4: 50, 5: 45, 6: 48, 7: 48});
INSERT INTO viagens (viagem_id, numero_comboio, partida, chegada, estacoes, n_pessoas_por_carruagem)
VALUES (uuid(), 404ee77d-b7b2-42f0-8cc4-11f36885b309, '2020-01-06 13:15:15', '2020-01-06 17:15:15', {'Porto', 'Ovar', 'Coimbra', 'Pombal', 'Aveiro', 'Lisboa'}, {21: 50, 22: 45, 23: 48, 81:40});
INSERT INTO viagens (viagem_id, numero_comboio, partida, chegada, estacoes, n_pessoas_por_carruagem)
VALUES (uuid(), 6c6c1722-6004-411c-867d-28479dcbfc4a, '2020-01-06 12:15:15', '2020-01-06 18:15:15', {'Porto', 'Ovar', 'Coimbra', 'Pombal', 'Aveiro', 'Lisboa'}, {21: 50, 22: 45, 23: 48, 81:40});
INSERT INTO viagens (viagem_id, numero_comboio, partida, chegada, estacoes, n_pessoas_por_carruagem)
VALUES (uuid(), 8befddd5-7f9b-47a7-ba77-e5ef712ccb0f, '2020-01-06 11:15:15', '2020-01-06 14:15:15', {'Castelo Branco', 'Tinalhas', 'Alcains'}, {1: 50, 2: 45, 3: 48, 4:90});
INSERT INTO viagens (viagem_id, numero_comboio, partida, chegada, estacoes, n_pessoas_por_carruagem)
VALUES (uuid(), 0d2d4ce1-9cb9-4ea4-9993-8e2c108c4252, '2020-01-06 10:15:15', '2020-01-06 12:15:15', {'Castelo Branco', 'Tinalhas', 'Alcains'}, {1: 50, 2: 45, 3: 48, 4:0, 5:0, 6:9});
INSERT INTO viagens (viagem_id, numero_comboio, partida, chegada, estacoes, n_pessoas_por_carruagem)
VALUES (uuid(), 35cf310a-ac8e-4117-a4f1-a06a3bf598a0, '2020-01-06 11:15:15', '2020-01-06 13:15:15', {'Porto', 'Coimbra', 'Aveiro', 'Lisboa'}, {1: 50, 2: 45, 3: 48});
INSERT INTO viagens (viagem_id, numero_comboio, partida, chegada, estacoes, n_pessoas_por_carruagem)
VALUES (uuid(), 00f7eb86-a65d-4717-836b-de98e037f2e0, '2020-01-06 15:15:15', '2020-01-06 16:15:15', {'Entroncamento', 'Castelo Branco', 'JMJ'}, {1: 50, 2: 45, 3: 48, 4:0});


INSERT INTO atrasos (atraso_id, viagem_id, duracao_atraso, razao_atraso)
VALUES (00000000-0000-0000-0000-000000000001, 389a2e5f-ce68-41fa-89cf-a5ee70bb8e29, 30, 'Problemas técnicos');
INSERT INTO atrasos (atraso_id, viagem_id, duracao_atraso, razao_atraso)
VALUES (00000000-0000-0000-0000-000000000002, 7b21abd0-2840-499a-a8b2-588adfd2c86b, 30, 'Suicídio');
INSERT INTO atrasos (atraso_id, viagem_id, duracao_atraso, razao_atraso)
VALUES (00000000-0000-0000-0000-000000000003, 404ee77d-b7b2-42f0-8cc4-11f36885b309, 30, 'Greve maquinistas');
INSERT INTO atrasos (atraso_id, viagem_id, duracao_atraso, razao_atraso)
VALUES (00000000-0000-0000-0000-000000000004, 404ee77d-b7b2-42f0-8cc4-11f36885b309, 30, 'Greve bar');
INSERT INTO atrasos (atraso_id, viagem_id, duracao_atraso, razao_atraso)
VALUES (00000000-0000-0000-0000-000000000005, 404ee77d-b7b2-42f0-8cc4-11f36885b309, 30, 'Greve revisores');
INSERT INTO atrasos (atraso_id, viagem_id, duracao_atraso, razao_atraso)
VALUES (00000000-0000-0000-0000-000000000006, ae7dfd2d-8b9a-4f8b-b22f-a45556c4e42e, 30, 'Greve infrastrruturas de portugal');
INSERT INTO atrasos (atraso_id, viagem_id, duracao_atraso, razao_atraso)
VALUES (00000000-0000-0000-0000-000000000007, ae7dfd2d-8b9a-4f8b-b22f-a45556c4e42e, 30, 'Greve de tudo');
INSERT INTO atrasos (atraso_id, viagem_id, duracao_atraso, razao_atraso)
VALUES (00000000-0000-0000-0000-000000000008, 00f7eb86-a65d-4717-836b-de98e037f2e0, 30, 'Greve porque sim');
INSERT INTO atrasos (atraso_id, viagem_id, duracao_atraso, razao_atraso)
VALUES (00000000-0000-0000-0000-000000000009, 00f7eb86-a65d-4717-836b-de98e037f2e0, 30, 'Problemas técnicos');
INSERT INTO atrasos (atraso_id, viagem_id, duracao_atraso, razao_atraso)
VALUES (00000000-0000-0000-0000-000000000010, 00f7eb86-a65d-4717-836b-de98e037f2e0, 30, 'Problemas técnicos');
INSERT INTO atrasos (atraso_id, viagem_id, duracao_atraso, razao_atraso)
VALUES (00000000-0000-0000-0000-000000000011, 6c6c1722-6004-411c-867d-28479dcbfc4a, 30, 'Problemas técnicos');
INSERT INTO atrasos (atraso_id, viagem_id, duracao_atraso, razao_atraso)
VALUES (00000000-0000-0000-0000-000000000012, 6c6c1722-6004-411c-867d-28479dcbfc4a, 30, 'Problemas técnicos');


INSERT INTO ex3_4.passageiro (passageiro_id, passageiro_name, passageiro_age, viagem_id, numero_comboio)
VALUES (uuid(), 'Diogo', 30, 389a2e5f-ce68-41fa-89cf-a5ee70bb8e29, 1);
INSERT INTO ex3_4.passageiro (passageiro_id, passageiro_name, passageiro_age, viagem_id, numero_comboio)
VALUES (uuid(), 'Diogo2', 30, 389a2e5f-ce68-41fa-89cf-a5ee70bb8e29, 1);
INSERT INTO ex3_4.passageiro (passageiro_id, passageiro_name, passageiro_age, viagem_id, numero_comboio)
VALUES (uuid(), 'Diogo3', 30, 389a2e5f-ce68-41fa-89cf-a5ee70bb8e29, 1);
INSERT INTO ex3_4.passageiro (passageiro_id, passageiro_name, passageiro_age, viagem_id, numero_comboio)
VALUES (uuid(), 'Diogo4', 30, 389a2e5f-ce68-41fa-89cf-a5ee70bb8e29, 1);
INSERT INTO ex3_4.passageiro (passageiro_id, passageiro_name, passageiro_age, viagem_id, numero_comboio)
VALUES (uuid(), 'Diogo5', 30, 389a2e5f-ce68-41fa-89cf-a5ee70bb8e29, 1);
INSERT INTO ex3_4.passageiro (passageiro_id, passageiro_name, passageiro_age, viagem_id, numero_comboio)
VALUES (uuid(), 'Diogo6', 30, 389a2e5f-ce68-41fa-89cf-a5ee70bb8e29, 1);
INSERT INTO ex3_4.passageiro (passageiro_id, passageiro_name, passageiro_age, viagem_id, numero_comboio)
VALUES (uuid(), 'Diogo7', 30, 389a2e5f-ce68-41fa-89cf-a5ee70bb8e29, 1);
INSERT INTO ex3_4.passageiro (passageiro_id, passageiro_name, passageiro_age, viagem_id, numero_comboio)
VALUES (uuid(), 'Diogo8', 30, 389a2e5f-ce68-41fa-89cf-a5ee70bb8e29, 1);


INSERT INTO ex3_4.passageiro (passageiro_id, passageiro_name, passageiro_age, viagem_id, numero_comboio)
VALUES (uuid(), 'Ana', 33, 52b17de1-01a0-41dd-8f6b-80854b237223, 2);
INSERT INTO ex3_4.passageiro (passageiro_id, passageiro_name, passageiro_age, viagem_id, numero_comboio)
VALUES (uuid(), 'Ana2', 33, 52b17de1-01a0-41dd-8f6b-80854b237223, 2);
INSERT INTO ex3_4.passageiro (passageiro_id, passageiro_name, passageiro_age, viagem_id, numero_comboio)
VALUES (uuid(), 'Ana3',44, 52b17de1-01a0-41dd-8f6b-80854b237223, 2);
INSERT INTO ex3_4.passageiro (passageiro_id, passageiro_name, passageiro_age, viagem_id, numero_comboio)
VALUES (uuid(), 'Ana4', 44, 52b17de1-01a0-41dd-8f6b-80854b237223, 2);
INSERT INTO ex3_4.passageiro (passageiro_id, passageiro_name, passageiro_age, viagem_id, numero_comboio)
VALUES (uuid(), 'Ana5', 44, 52b17de1-01a0-41dd-8f6b-80854b237223, 2);
INSERT INTO ex3_4.passageiro (passageiro_id, passageiro_name, passageiro_age, viagem_id, numero_comboio)
VALUES (uuid(), 'Ana6', 44, 52b17de1-01a0-41dd-8f6b-80854b237223, 2);
INSERT INTO ex3_4.passageiro (passageiro_id, passageiro_name, passageiro_age, viagem_id, numero_comboio)
VALUES (uuid(), 'Ana7', 44, 52b17de1-01a0-41dd-8f6b-80854b237223, 2);
INSERT INTO ex3_4.passageiro (passageiro_id, passageiro_name, passageiro_age, viagem_id, numero_comboio)
VALUES (uuid(), 'Ana8', 44, 52b17de1-01a0-41dd-8f6b-80854b237223, 2);

CREATE INDEX IF NOT EXISTS "index1" ON comboio (velocidade) ;
CREATE INDEX IF NOT EXISTS "index2" ON atrasos (duracao_atraso) ;


UPDATE viagens SET n_pessoas_por_carruagem = {1: 45, 2: 40, 3: 43, 4: 0} WHERE viagem_id = 52b17de1-01a0-41dd-8f6b-80854b237223 AND numero_comboio = 00f7eb86-a65d-4717-836b-de98e037f2e0;
UPDATE viagens SET n_pessoas_por_carruagem = {1: 48, 2: 42, 3: 45, 4: 5} WHERE viagem_id = 52b17de1-01a0-41dd-8f6b-80854b237223 AND numero_comboio = 00f7eb86-a65d-4717-836b-de98e037f2e0;
UPDATE viagens SET n_pessoas_por_carruagem = {1: 50, 2: 45, 3: 48, 4: 0} WHERE viagem_id = 52b17de1-01a0-41dd-8f6b-80854b237223 AND numero_comboio = 00f7eb86-a65d-4717-836b-de98e037f2e0;
UPDATE viagens SET n_pessoas_por_carruagem = {1: 55, 2: 50, 3: 50, 4: 5} WHERE viagem_id = 52b17de1-01a0-41dd-8f6b-80854b237223 AND numero_comboio = 00f7eb86-a65d-4717-836b-de98e037f2e0;
UPDATE viagens SET n_pessoas_por_carruagem = {1: 48, 2: 43, 3: 45, 4: 2} WHERE viagem_id = 52b17de1-01a0-41dd-8f6b-80854b237223 AND numero_comboio = 00f7eb86-a65d-4717-836b-de98e037f2e0;


DELETE FROM comboio WHERE numero_comboio = a07113b2-1bb8-452b-96f3-f73c3f1cb2fe;
DELETE FROM comboio WHERE numero_comboio = 35df08b1-a7fa-4222-9c4d-5ad30760dcb2;
DELETE FROM comboio WHERE numero_comboio = 35cf310a-ac8e-4117-a4f1-a06a3bf598a0;

SELECT * FROM comboio WHERE tipo_comboio = 'IC' ALLOW FILTERING ;

--  numero_comboio                       | tipo_comboio | carruagens   | lugares | velocidade
-- --------------------------------------+--------------+--------------+---------+------------
--  7b21abd0-2840-499a-a8b2-588adfd2c86b |           IC | [1, 2, 3, 4] |     400 |        180
--  404ee77d-b7b2-42f0-8cc4-11f36885b309 |           IC | [1, 2, 3, 4] |     400 |        180
--  6c6c1722-6004-411c-867d-28479dcbfc4a |           IC | [1, 2, 3, 4] |     400 |        180
--  00f7eb86-a65d-4717-836b-de98e037f2e0 |           IC | [1, 2, 3, 4] |     400 |        180


SELECT * FROM atrasos WHERE razao_atraso = 'Problemas técnicos' allow filtering;

--  atraso_id                            | viagem_id                            | duracao_atraso | razao_atraso
-- --------------------------------------+--------------------------------------+----------------+--------------------
--  00000000-0000-0000-0000-000000000011 | 6c6c1722-6004-411c-867d-28479dcbfc4a |             30 | Problemas técnicos
--  00000000-0000-0000-0000-000000000010 | 00f7eb86-a65d-4717-836b-de98e037f2e0 |             30 | Problemas técnicos
--  00000000-0000-0000-0000-000000000001 | 389a2e5f-ce68-41fa-89cf-a5ee70bb8e29 |             30 | Problemas técnicos
--  00000000-0000-0000-0000-000000000009 | 00f7eb86-a65d-4717-836b-de98e037f2e0 |             30 | Problemas técnicos
--  00000000-0000-0000-0000-000000000012 | 6c6c1722-6004-411c-867d-28479dcbfc4a |             30 | Problemas técnicos

SELECT * FROM comboio WHERE tipo_comboio = 'IC' ALLOW FILTERING ;

--  numero_comboio                       | tipo_comboio | carruagens   | lugares | velocidade
-- --------------------------------------+--------------+--------------+---------+------------
--  7b21abd0-2840-499a-a8b2-588adfd2c86b |           IC | [1, 2, 3, 4] |     400 |        180
--  404ee77d-b7b2-42f0-8cc4-11f36885b309 |           IC | [1, 2, 3, 4] |     400 |        180
--  6c6c1722-6004-411c-867d-28479dcbfc4a |           IC | [1, 2, 3, 4] |     400 |        180
--  00f7eb86-a65d-4717-836b-de98e037f2e0 |           IC | [1, 2, 3, 4] |     400 |        180

SELECT * FROM comboio WHERE velocidade > 160 ALLOW FILTERING ;

--  numero_comboio                       | tipo_comboio | carruagens   | lugares | velocidade
-- --------------------------------------+--------------+--------------+---------+------------
--  7b21abd0-2840-499a-a8b2-588adfd2c86b |           IC | [1, 2, 3, 4] |     400 |        180
--  404ee77d-b7b2-42f0-8cc4-11f36885b309 |           IC | [1, 2, 3, 4] |     400 |        180
--  6c6c1722-6004-411c-867d-28479dcbfc4a |           IC | [1, 2, 3, 4] |     400 |        180
--  00f7eb86-a65d-4717-836b-de98e037f2e0 |           IC | [1, 2, 3, 4] |     400 |        180

SELECT * FROM comboio WHERE tipo_comboio = 'Regional' AND velocidade >= 150 ALLOW FILTERING ;

--  numero_comboio                       | tipo_comboio | carruagens      | lugares | velocidade
-- --------------------------------------+--------------+-----------------+---------+------------
--  ae7dfd2d-8b9a-4f8b-b22f-a45556c4e42e |     Regional | [1, 2, 3, 4, 5] |     290 |        150
--  0ff34aec-a82d-45c8-a4e7-ec4d2f6fa533 |     Regional |    [1, 2, 3, 4] |     230 |        150
--  8befddd5-7f9b-47a7-ba77-e5ef712ccb0f |     Regional |    [1, 2, 3, 4] |     230 |        150

SELECT * FROM comboio WHERE numero_comboio = 35df08b1-a7fa-4222-9c4d-5ad30760dcb2 AND tipo_comboio = 'IC';