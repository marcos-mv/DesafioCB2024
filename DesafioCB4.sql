--Bônus (se desafie a fazer!): Escreva uma consulta que retorne, para cada mês, o produto mais 
--vendido e o produto menos vendido, junto com a quantidade de unidades vendidas e a respectiva 
--loja associada a essas vendas. Aqui é sugerido o uso de uma sub consulta.

WITH RankedProducts AS (
    SELECT
        EXTRACT(YEAR FROM s.dt_sale) AS year,
        EXTRACT(MONTH FROM s.dt_sale) AS month,
        p.desc_prod,
        st.desc_store,
        s.sk_prod,
        s.sk_store,
        SUM(s.sale_quantity) AS total_quantity,
        ROW_NUMBER() OVER (PARTITION BY EXTRACT(YEAR FROM s.dt_sale), EXTRACT(MONTH FROM s.dt_sale) ORDER BY SUM(s.sale_quantity) DESC) AS rank_most_sold,
        ROW_NUMBER() OVER (PARTITION BY EXTRACT(YEAR FROM s.dt_sale), EXTRACT(MONTH FROM s.dt_sale) ORDER BY SUM(s.sale_quantity) ASC) AS rank_least_sold
    FROM
        cb_sale s
        JOIN cb_product p ON s.sk_prod = p.sk_prod
        JOIN cb_store st ON s.sk_store = st.sk_store
    GROUP BY
        EXTRACT(YEAR FROM s.dt_sale),
        EXTRACT(MONTH FROM s.dt_sale),
        p.desc_prod,
        st.desc_store,
        s.sk_prod,
        s.sk_store
)
SELECT
    year,
    month,
    desc_prod AS most_sold_product,
    desc_store AS most_sold_store,
    total_quantity AS most_sold_quantity,
    (
        SELECT desc_prod
        FROM RankedProducts
        WHERE rank_least_sold = 1 AND year = R.year AND month = R.month
    ) AS least_sold_product,
    (
        SELECT desc_store
        FROM RankedProducts
        WHERE rank_least_sold = 1 AND year = R.year AND month = R.month
    ) AS least_sold_store,
    (
        SELECT total_quantity
        FROM RankedProducts
        WHERE rank_least_sold = 1 AND year = R.year AND month = R.month
    ) AS least_sold_quantity
FROM RankedProducts R
WHERE rank_most_sold = 1;
