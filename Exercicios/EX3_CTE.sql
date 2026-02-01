WITH total_faturamento 
AS 
(
  SELECT
    CLIENTES.nome AS nome_Cliente,
    ROUND(SUM(VENDAS.quantidade * VENDAS.preco),1) AS faturamento_total,
    quantidade
  FROM
    curso-bigquery04242.Belleza_verde.vendas VENDAS
  INNER JOIN
    curso-bigquery04242.Belleza_verde.clientes CLIENTES 
    ON VENDAS.id_cliente = CAST(CLIENTES.id_cliente AS INT64)
  WHERE EXTRACT(YEAR FROM data) = 2021
  GROUP BY
    CLIENTES.nome, quantidade
),

faturamento_ranking
AS
(
  SELECT
    nome_cliente,
    faturamento_total,
    RANK() OVER(ORDER BY faturamento_total DESC) ranking,
    SUM(faturamento_total) OVER() total_vendas 
  FROM total_faturamento
  GROUP BY nome_cliente, faturamento_total 
)

SELECT 
  nome_cliente,
  total_vendas,
  faturamento_total,
  ROUND(((faturamento_total / total_vendas)*100),2) percentual_distribuicao,
  ranking
FROM faturamento_ranking