# Organização de base de dados

-> Collection <String, k> (chaves em readis são strings e um valor k) - podem ser mapas, listas, sets, hash

Redis permite aceder a este mapa lógico usado puts, gets, etc

Guarda dados acessados frequentemente na base de dados

Não podemos fazer operações dificeis, mesmo até joins ou agreggate. Isto reduz muito a complexidade para aguentar mais dados. (keep it simple and fast)

Usamos comandos para trabalhar no redis: https://redis.io/commands/ 

Outras funcionalidades incluem data de validade e autocleans para key/pares

Commands: para sets, comando começa por S, para hash, começa por H, etc

Correr ficheiros: cat "CBD...bach" | redis-cli

____________________________________________________________________________

# ficheiros para entregar:

-> CBD-11-108712.txt ✅
-> CBD-12.batch.txt ✅
-> CBD-12.txt ✅
-> ficheiros .java dos 2 exercícios do (4) ✅ 1/2
-> CBD-14a-out.txt ✅
-> CBD-14b-out.txt
-> ficheiros .java dos 2 exercícios do (5) 0/2
-> CBD-15a-out.txt
-> CBD-15b-out.txt