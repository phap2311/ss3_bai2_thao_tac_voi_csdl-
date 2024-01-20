drop database if exists quan_ly_ban_hang_a;
create database if not exists quan_ly_ban_hang_a;
use quan_ly_ban_hang_a;
create table customer(
c_id int primary key auto_increment not null,
c_name varchar(30) not null,
c_age int check (c_age>0)
);
create table order_goods(
o_id int primary key auto_increment not null,
c_id int  not null,
o_date date not null,
o_total_price long ,
foreign key (c_id) references customer (c_id)
);
create table product(
p_id int primary key ,
p_name varchar(30) not null,
p_price int check (p_price>0)
);
create table order_detail(
o_id int,
p_id int,
od_qty int,
primary key (o_id,p_id),
foreign key (o_id) references order_goods(o_id),
foreign key (p_id) references product(p_id)
);
insert into customer (c_id, c_name, c_age)
values (1,"Minh Quan",10),
(2,"Ngoc Oanh",20),
(3,"Hong Ha",50);
insert into order_goods(o_id,c_id,o_date,o_total_price)
values(1,1,"2006-03-21",null),
(2,2,"2006-03-23",null),
(3,1,"2006-03-16",null);
insert into product(p_id,p_name,p_price)
values (1,"May Giat",3),
(2,"Tu Lanh",5),
(3,"Dieu Hoa",7),
(4,"Quat",1),
(5,"Bep Dien",2);
insert into order_detail(o_id,p_id,od_qty)
values 
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);
 
 -- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
 select o_id, o_date, o_total_price from order_goods;

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select distinct customer.c_name, product.p_name
from customer join order_goods on customer.c_id = order_goods.c_id
join order_detail on order_detail.o_id = order_goods.o_id
join product on product.p_id = order_detail.p_id;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select customer.c_name , order_goods.o_id
from customer left join order_goods on customer.c_id = order_goods.c_id
where order_goods.o_id is null;


-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn 
-- (Giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn ,Giá bán của từng loại được tính = odQTY*pPrice)
select order_goods.o_id as ma_hoa_don, order_goods.o_date as ngay_mua, sum(product.p_price * order_detail.od_qty) as tong_tien
from order_goods join order_detail on order_detail.o_id = order_goods.o_id
join product on product.p_id = order_detail.p_id
group by order_goods.o_id, order_goods.o_date;


