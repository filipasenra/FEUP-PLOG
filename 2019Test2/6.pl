/*
Variáveis de Decisão: Lista com o Mesmo Comprimento da Listas Com Os 
Objetos. (N variáveis de decisão, sendo N o número de Objetos)

Dominio: 1 a X, sendo X nº de compartimentos.

Significado: Cada variável com indice N representa a prateleira do 
objeto de indice N (na lista Objectos).

Resolução: Para restringir os objetos a prateleiras em que o volume 
total dos objetos seja inferior ou igual ao volume da pratelira, 
irei optar por usar o predicado Cumulatives.
Cada objecto corresponde a uma task com consumo de recursos igual 
ao seu volume, Identificador da Máquina igual à variável do mesmo índice
na Lista Vars, Começo igual a 0, duração e fim igual ao seu volume.
Cada prateleira corresponde a uma machine com Identificador igual ao seu
índice na lista Prateleiras e Limite de Recursos igual ao seu volume máximo.
Para restringir o facto de que uma prateleira imediatamente acima de outra
deve ter um peso inferior ou igual, iremos calcular o peso de cada prateleira
e restringir que o peso da prateleira superior tem de ser menor que o da inferior.


*/