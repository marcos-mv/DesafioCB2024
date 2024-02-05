-- 3. Escreva uma consulta que apresente o lucro obtido com as vendas por loja, em que o retorno da consulta seja o nome da loja e valor do lucro
-- obtido. Lembrando que o valor apresentado na coluna ‘sale_profit’ significa a porcentagem de lucro daquela venda.

select
	cb_store.desc_store as store_name ,
	SUM(cb_sale.sale_total * cb_sale.sale_profit) as total_profit
from
	cb_store
inner join cb_sale
on
	cb_store.sk_store = cb_sale.sk_store
group by
	store_name
order by
	total_profit DESC;

