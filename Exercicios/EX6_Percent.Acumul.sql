
WITH VENDAS_ANUAIS 

AS
(
  SELECT
    Vendedor.id_vendedor,Vendedor.nome AS nome_vendedor,
    PRODUTOS.id_produto, PRODUTOS.nome AS nome_produto, 
    EXTRACT(YEAR FROM VENDAS.data) AS ano,
    SUM(VENDAS.quantidade) AS total_vendas,
  FROM
    `Belleza_verde.vendas` VENDAS
  INNER JOIN
    `Belleza_verde.produtos` Produtos 
    ON VENDAS.id_produto = PRODUTOS.id_produto
  INNER JOIN
    curso-bigquery04242.Belleza_verde.clientes CLIENTES
    ON VENDAS.id_cliente = CLIENTES.id_cliente
  INNER JOIN 
    `Belleza_verde.vendedores` Vendedor
    ON CLIENTES.id_vendedor = Vendedor.id_vendedor
  GROUP BY 
    Vendedor.nome, PRODUTOS.nome, 
    EXTRACT(YEAR FROM VENDAS.data),Vendedor.id_vendedor, PRODUTOS.id_produto
),

Total_venda
AS
(
  SELECT
    VA.nome_vendedor  nome_vendedor,
    VA.nome_produto nome_produto,
    VA.ano  ano,
    VA.total_vendas quant_vendas,
    METAS.quantidade_meta AS quant_meta,
    CASE WHEN VA.total_vendas >= METAS.quantidade_meta THEN  "Bom" ELSE "Ruim" END AS status_meta,
    SUM(total_vendas) OVER() total_vendas
  FROM 
    VENDAS_ANUAIS VA
  INNER JOIN
    `curso-bigquery04242.Belleza_verde.metas` METAS 
    ON VA.id_produto = METAS.id_produto
    AND VA.id_vendedor = METAS.id_vendedor
    AND VA.ano = METAS.ano
),

rank
AS 
(
  SELECT
    RANK()OVER(ORDER BY quant_vendas DESC) ranking,
    nome_vendedor,
    nome_produto,
    ano,
    quant_vendas,
    ROUND((quant_vendas / SUM(quant_vendas)OVER())*100,2) AS percentual_distribuicao,
    quant_meta,
    CONCAT(ROUND((((quant_vendas/quant_meta)-1)*100),2),'%') performance,
    status_meta
  FROM Total_venda
)

SELECT
  ranking,
  nome_vendedor,
  nome_produto,
  COUNT(*)OVER() AS total_produtos,
  ano,
  quant_vendas,
  CONCAT(ROUND(SUM(percentual_distribuicao)OVER(ORDER BY ranking ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),2),'%') AS distribuicao_percentual,
  quant_meta,
  CONCAT(ROUND((((quant_vendas/quant_meta)-1)*100),2),'%') performance,
  status_meta
FROM rank



