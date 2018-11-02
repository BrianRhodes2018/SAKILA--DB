-- 1a
use sakila;

select * from actor;

-- 1b
SELECT CONCAT(first_name, ' ' , last_name) as 'Actor Name' 
FROM actor;

-- 2a
select first_name, last_name, actor_id 
from actor
where first_name = 'Joe';

-- 2b    
select first_name, last_name 
from actor
where last_name like '%GEN%';

-- 2c

select  last_name, first_name from actor
where last_name like '%LI%';
    
-- 2d 

select  country_id, country from country
where country in ("Afghanistan","Bangladesh", "China");
    
-- 3a

alter table actor
add description BLOB;

-- 3b

alter table actor
drop column description;
    
-- 4a

select last_name, count(*) as same_name 
from actor
group by last_name
having count(last_name) >1;
    
-- 4c
select first_name, last_name 
from actor;

update actor
set first_name="HARPO"
where first_name="GROUCHO" and last_name="WILLIAMS";

-- 4d

update actor
set first_name="GROUCHO"
where first_name="HARPO" and last_name="WILLIAMS";

-- 5a

show create table address;

-- 6a

select first_name, last_name, address 
from staff
inner join address
    on staff.address_id=address.address_id;
   
    
-- 6b. 

select first_name, last_name, payment_date, sum(amount)
from staff
inner join payment
	on staff.staff_id=payment.staff_id
where payment_date like "2005-08%"
group by first_name, last_name;


-- * 6c. 

select title, count(actor_id)
from film
inner join film_actor
	on film.film_id=film_actor.film_id
group by title;


-- * 6d. 

select title, count(inventory_id)
from film
inner join inventory
	on film.film_id=inventory.film_id
group by title;

-- * 6e. 

select last_name, sum(amount)
from customer
inner join payment
	on customer.customer_id=payment.customer_id
group by last_name;


-- * 7a. 

select title, (name)
from (language)
inner join film
	on language.language_id=film.language_id
where title like "K%" or title like "Q%";

-- * 7b.

SELECT first_name, last_name, title
FROM film_actor
INNER JOIN actor
   ON  film_actor.actor_id=actor.actor_id
INNER JOIN film
   ON  film_actor.film_id=film.film_id
where title like "Alone Trip";

-- * 7c. 

select first_name, last_name, email
from customer
inner join address
	on customer.address_id=address.address_id
inner join city
	on address.city_id=city.city_id
inner join country
	on country.country_id=city.country_id
where country like "Canada";

-- * 7d. 

select title, (name)
from category
inner join film_category
	on category.category_id=film_category.category_id
inner join film
	on film.film_id=film_category.film_id
where (name) like "family";


-- 7e. 

select title, count(rental_id) as number_of_rentals
from rental
inner join inventory
	on rental.inventory_id=inventory.inventory_id
inner join film
	on inventory.film_id=film.film_id
group by title
order by number_of_rentals desc;

-- Not sure what went wrong on the last one I got to
-- * 7f. Write a query to display how much business, in dollars, each store brought in.

select * from payment; -- amount, staff_id 
select * from staff; -- staff_id, address_id
select * from store; -- store_id, address_id


select store_id, sum(amount) as total_sales
from store
inner join staff
	on staff.address_id=store.address_id
inner join payment
	on payment.staff_id=staff.staff_id
group by store_id;

