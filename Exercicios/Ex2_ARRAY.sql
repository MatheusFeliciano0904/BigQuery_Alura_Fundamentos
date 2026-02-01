WITH produtos_indexados AS (
  SELECT 
    id_produto,
    nome,
    categoria,
    preco,
    mp AS materia_principal,
    off AS posicao
  FROM `curso-bigquery04242.Belleza_verde.produtos`,
  UNNEST(materiasprimas) AS mp WITH OFFSET off
  WHERE preco > 50
),

filtro_primeira_materia AS (
  SELECT 
    id_produto,
    nome,
    categoria,
    preco,
    materia_principal
  FROM produtos_indexados
  WHERE posicao = 0
)

SELECT 
  categoria,
  COUNT(id_produto) AS total_produtos_premium,
  ARRAY_AGG(nome ORDER BY preco DESC) AS lista_produtos_premium,
  ARRAY_AGG(DISTINCT materia_principal) AS materias_principais_unicas
FROM filtro_primeira_materia
GROUP BY categoria
ORDER BY total_produtos_premium DESC;



