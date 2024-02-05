
-- Consulta que liste os nomes das lojas que tiveram os maiores
-- faturamentos com as vendas de produtos e que são da localização “Asa Sul”.
-- Considere faturamento igual à soma do valor pago dos pedidos.

select
	cb_store.desc_store as store_name ,
	SUM(cb_sale.sale_total) as total_revenue
from
	cb_store
inner join cb_sale
on
	cb_store.sk_store = cb_sale.sk_store
inner join cb_location
on
	cb_sale.sk_loc = cb_location.sk_loc
where
	cb_location.desc_loc = 'ASA SUL'
group by
	store_name
order by
	total_revenue DESC;
