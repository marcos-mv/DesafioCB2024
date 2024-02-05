-- 1. Escreva uma consulta que apresente quais foram os produtos 
-- mais vendidos, em termos de quantidade total de vendas, no ano de 2019.

select
	cb_product.id_prod,
	cb_product.desc_prod,
	SUM(cb_sale.sale_quantity) as total_quantity_sold
from
	cb_product
join
   cb_sale on
	cb_product.sk_prod = cb_sale.sk_prod
where
	extract(year
from
	cb_sale.dt_sale) = 2019
group by
	cb_product.id_prod,
	cb_product.desc_prod
order by
	total_quantity_sold desc;
