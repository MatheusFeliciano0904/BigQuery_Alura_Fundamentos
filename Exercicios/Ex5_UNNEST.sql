WITH index_produtos AS (
  SELECT 
    id_produto,
    nome,
    categoria,
    preco,
    ARRAY(
      SELECT AS STRUCT mp_val, ROW_NUMBER() OVER() AS idx 
      FROM UNNEST(materiasprimas) AS mp_val
    ) AS materiaprima_index,
    ARRAY(
      SELECT AS STRUCT ds_val, ROW_NUMBER() OVER() AS idx 
      FROM UNNEST(distribuicao) AS ds_val
    ) AS distribuicao_index
  FROM `curso-bigquery04242.Belleza_verde.produtos`
)

SELECT
  ip.id_produto,
  ip.nome,
  ip.categoria,
  ip.preco,
  mpUN.mp_val AS id_materia,
  dsUN.ds_val AS distribuicao_materia
FROM index_produtos ip
CROSS JOIN UNNEST(ip.materiaprima_index) AS mpUN
CROSS JOIN UNNEST(ip.distribuicao_index) AS dsUN
WHERE mpUN.idx = dsUN.idx;


