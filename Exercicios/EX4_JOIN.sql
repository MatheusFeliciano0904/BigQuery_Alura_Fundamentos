WITH VENDAS

AS 
(
  SELECT
    id_venda,
    id_produto,
    id_cliente,
    data,
    EXTRACT(YEAR FROM data) AS ano,
    quantidade,
    preco
  FROM `Belleza_verde.vendas`
),

CLIENTES

AS 
(
  SELECT
    id_cliente,
    nome,
    email,
    localizacao,
    id_vendedor
  FROM `Belleza_verde.clientes`
),

total_faturamento

AS 
(
  SELECT
    C.nome AS Vendedor,
    ROUND(SUM(V.quantidade * V.preco),2) AS Faturamento,
    ano
  FROM VENDAS V
  JOIN CLIENTES C ON V.id_cliente = C.id_cliente
  WHERE V.ano = 2021
  GROUP BY Vendedor, ano
)

SELECT
  Vendedor,
  Faturamento,
  ano
FROM total_faturamento











