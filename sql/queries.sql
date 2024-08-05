create database site;
use site;

-- EXERCICIO 1
create table CLIENTS(
id int auto_increment primary key,
nome varchar(70) not null,
email varchar(70) not null
);

-- EXERCICIO 2
create table PRODUCTS(
id int auto_increment primary key,
nome varchar(70) not null,
price decimal not null
);
alter table PRODUCTS modify column price decimal(5,2) not null;

-- EXERCICIO 3
create table ORDERS(
id int auto_increment primary key,
client_id int,
foreign key (client_id) references CLIENTS(id),
order_date date not null,
total decimal not null
);
alter table ORDERS modify column total decimal(5,2) not null;

-- EXERCICIO 4
create table ORDER_ITEMS(
order_id int,
foreign key (order_id) references ORDERS(id),
product_id int,
foreign key (product_id) references PRODUCTS(id),
quantity int not null,
price decimal not null
);
alter table ORDER_ITEMS modify column price decimal(5,2) not null;

-- EXERCICIO 5
insert into CLIENTS (nome, email) values
("Maria", "maria@gmail.com"),
("João", "joao@gmail.com"),
("Felipe", "felipe@gmail.com"),
("Amanda", "amanda@gmail.com"),
("Gustavo", "gustavo@gmail.com"),
("Joaquina", "joaquina@gmail.com");

-- EXERCICO 5
insert into PRODUCTS (nome, price) values
("Abacate Kg", 4.99),
("Arroz 5Kg", 7.99),
("Batata Kg", 3.99),
("Pepsi Lata", 4.50),
("Ovo 20un", 12.99),
("Suco de laranja", 3.50);

-- EXERCICIO 6
insert into ORDERS (order_date, total, client_id) values
("2024-07-30", 14.90, 6),
("2024-03-14", 22.40, 4),
("2024-08-03", 37.30, 5),
("2024-05-09",42.87, 1),
("2024-09-13", 11.11, 6);

-- EXERCICIO 7
insert into ORDER_ITEMS (order_id, product_id, quantity, price) values -- EXERCICIO 7
(1, 4, 3, 40.70),
(2, 1, 2, 24.90),
(4, 5, 4, 45.80),
(5, 6, 3, 20.00);

-- EXERCICIO 8
update PRODUCTS set price = 2.99 where id = 3;
update ORDER_ITEMS set price = 2.99 where id = 3; -- exemplo

-- EXERCICIO 9
delete from ORDER_ITEM where order_id = 3; -- exemplo
delete from ORDERS where client_id = 5;
delete from CLIENTS where id = 5; 

-- EXERCICIO 10
alter table CLIENTS add column birthdate date;

-- EXERCICIO 11
select ORDERS.id as id_do_pedido, CLIENTS.nome as nome_do_cliente, PRODUCTS.nome as nome_do_produto
from ORDERS
inner join CLIENTS on CLIENTS.id = ORDERS.client_id
inner join PRODUCTS on PRODUCTS.id = CLIENTS.id

-- EXERCICIO 12 
select CLIENTS.nome as nome_do_cliente, ORDERS.id as id_do_pedido
from CLIENTS
left join ORDERS on CLIENTS.id = ORDERS.client_id;

-- EXERCICIO 13
select PRODUCTS.nome, ORDERS.id
from ORDERS
inner join ORDER_ITEMS on ORDER_ITEMS.order_id = ORDERS.id
right join PRODUCTS on ORDER_ITEMS.product_id = PRODUCTS.id;

select total from orders

-- EXERCICIO 14
select SUM(total) as total_vendas, SUM(quantity) as total_produdots_vendidos
from ORDERS
inner join ORDER_ITEMS on ORDER_ITEMS.order_id = ORDERS.id;
-- O PRECO TOTAL É INFERIOR PQ FIZ UM EXERCICIO DE DELETAR ALGUM PEDIDO OU PRECO

-- EXERCICIO 15
select nome as clientes, COUNT(quantity) as total_pedidos_realizados
from CLIENTS
inner join ORDERS on ORDERS.client_id = CLIENTS.id
inner join ORDER_ITEMS on ORDER_ITEMS.order_id = ORDERS.id
GROUP BY clientes;

-- EXERCICIO 16
select PRODUCTS.nome as produtos, SUM(quantity) as quantidade
from PRODUCTS
left join ORDER_ITEMS on ORDER_ITEMS.product_id = PRODUCTS.id
group by produtos
order by quantidade DESC;

-- EXERCICIO 17
select CLIENTS.nome as clientes, SUM(total) valor_gasto
from CLIENTS
left join ORDERS on ORDERS.client_id = CLIENTS.id
group by clientes
order by valor_gasto DESC;

-- EXERCICIO 18
select PRODUCTS.nome as produtos, SUM(quantity) as quantidade_vendidos, SUM(total) as total_vendas
from PRODUCTS
left join ORDER_ITEMS on ORDER_ITEMS.product_id = PRODUCTS.id
inner join ORDERS on ORDERS.id = ORDER_ITEMS.order_id
group by produtos
order by quantidade_vendidos
limit 3;

-- EXERCICO 19
select CLIENTS.nome, SUM(total)
from CLIENTS
inner join ORDERS on ORDERS.client_id = CLIENTS.id
inner join ORDER_ITEMS on ORDER_ITEMS.order_id = ORDERS.id
group by CLIENTS.nome
limit 3;

-- EXERCICIO 20
select AVG(quantity) as media_de_pedidos, CLIENTS.nome
from ORDER_ITEMS
inner join ORDERS on ORDERS.id = ORDER_ITEMS.order_id
inner join CLIENTS on CLIENTS.id = ORDERS.client_id
group by CLIENTS.nome;

select month(order_date) from orders;

-- EXERCICIO 21 
select count(order_id) as total_pedidos, count(client_id) as total_clientes, month(order_date) as mes
from ORDER_ITEMS
inner join ORDERS on ORDERS.id = ORDER_ITEMS.order_id 
inner join CLIENTS on CLIENTS.id = ORDERS.client_id
group by mes;

-- EXERCICIO 22  -- retorna arroz e batata
select PRODUCTS.nome
from PRODUCTS
inner join ORDER_ITEMS on ORDER_ITEMS.product_id = PRODUCTS.id where (product.id = null)
left join ORDERS on ORDERS.id = ORDER_ITEMS.order_id;

-- EXERCICIO 23

-- EXERCICIO 24   -- 09
select CLIENTS.nome, month(orders.order_date) as mes 	
from ORDERS -- where month(order_date)
inner join ORDER_ITEMS on ORDERS.id = ORDER_ITEMS.order_id
inner join CLIENTS on CLIENTS.id = ORDERS.client_id
group by mes, CLIENTS.nome
order by mes desc
limit 1;

-- EXERCUCIO 25
select CLIENTS.nome, avg(total)
from ORDERS
inner join CLIENTS on CLIENTS.id = ORDERS.client_id
group by total, CLIENTS.nome
order by total desc
limit 1;
