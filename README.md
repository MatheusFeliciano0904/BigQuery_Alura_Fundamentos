EXERCÍCIO 1  - CTE (Common Table Expression)

```
Crie um relatório de ranking de vendas por produto e vendedor, comparando o realizado contra a meta anual. O resultado deve mostrar o nome do vendedor, o produto, o ano, a quantidade vendida, a meta, o status ('Bom' ou 'Ruim') e a porcentagem de performance

```



EXERCÍCIO 2  - CTE (Common Table Expression)

```

Escreva uma query no BigQuery que calcule o faturamento por cliente em 2021, gere um ranking por faturamento, calcule o total geral de vendas e o percentual de participação de cada cliente usando CTEs e funções analíticas


```

EXERCÍCIO 3  - ARRAY_AGG & JOIN

```

Vamos então praticar?

Crie uma consulta CTE com o nome de total_faturamento. Esta consulta deve nos dar o valor do faturamento dentro do ano de 2021 por nome do cliente.
Dicas:

Faça um INNER JOIN entre a tabela de vendas e de clientes pelo campo id_cliente;
Na hora de fazer a igualdade preste a atenção porque os campos id_cliente da tabela de vendas e clientes são de tipos diferentes;
Faça uma agregação do faturamento por soma multiplicando quantidade com preco;
Filtre os dados pelo campo data extraindo o ano e igualando ao valor de 2021.


```


EXERCÍCIO 4  - UNNEST

```

Você está trabalhando com um conjunto de dados de produtos da empresa Belleza Verde, armazenados no BigQuery dentro do dataset curso-big-query-12339.belleza_verde_vendas.

Cada registro na tabela produtos inclui informações sobre o produto, como id_produto, nome, categoria, e preco. Além disso, existem dois campos importantes armazenados como arrays: materiasprimas e distribuicao, que contêm, respectivamente, as matérias-primas utilizadas para produzir o produto e os pontos de distribuição.

Sua tarefa é analisar a correlação entre as matérias-primas e os pontos de distribuição para cada produto, considerando a ordem em que estão listados. Dessa forma, você deve criar uma consulta SQL no BigQuery para:

Atribuir índices sequenciais a cada elemento nos arrays materiasprimas e distribuicao para cada produto.
Realizar uma junção desses índices de modo a correlacionar cada matéria-prima com um ponto de distribuição, baseado na ordem sequencial.
Selecionar os detalhes do produto (id_produto, nome, categoria, preco) e os elementos correlacionados (id_materia da materiasprimas e distribuicao_materia da distribuicao), garantindo que cada matéria-prima esteja associada ao seu correspondente ponto de distribuição pela ordem de listagem.
Dicas:

Utilize uma subquery para preparar os dados, atribuindo índices a cada elemento nos arrays materiasprimas e distribuicao.
Aplique a função UNNEST para expandir os arrays e a função ROW_NUMBER para gerar índices sequenciais.
Realize junções cruzadas (CROSS JOIN) entre as matérias-primas e os pontos de distribuição, baseando-se nos índices gerados, para associar cada matéria-prima ao seu respectivo ponto de distribuição.
Certifique-se de remover a vírgula extra após o último ARRAY na CTE para evitar erros de sintaxe.
Selecione as informações desejadas dos produtos e apresente os resultados de maneira clara e organizada.

```

EXERCÍCIO 5  - ARRAY_AGG & UNNEST


```

A empresa Belleza Verde iniciou uma auditoria de sustentabilidade. Você precisa gerar um relatório que identifique a primeira matéria-prima (índice 1) de cada produto, mas apenas para os produtos que custam mais de R$ 50,00.

Além disso, o resultado final deve ser agrupado por Categoria, mostrando:

A categoria.

A quantidade total de produtos auditados nessa categoria.

Um ARRAY contendo o nome dos produtos (ordenados do mais caro para o mais barato).

Um ARRAY contendo apenas as "Matérias-Primas Principais" (aquelas que estavam na primeira posição do array original) de todos os produtos daquela categoria, sem repetições (únicas).

```

EXERCÍCIO 6  - Percentual_Acumulado


```

Qual o ranking de desempenho dos vendedores por produto e ano, comparando as quantidades vendidas versus as metas e calculando a participação percentual acumulada de cada venda no total geral?


```