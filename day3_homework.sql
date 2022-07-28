-- 1. List all customers who live in Texas (use JOINs)
SELECT customer.customer_id, customer.first_name, customer.last_name, customer.email, city.city
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON address.city_id =  city.city_id
WHERE city = 'Texas';


-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS full_name, payment.amount, payment.payment_id
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
ORDER BY amount;


-- 3. Show all customers names who have made payments over $175 (use subqueries)
-- SUBQUERIES
SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS full_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
    ORDER BY SUM(amount)
);

-- JOINS (I LIKE JOINS!)
SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS full_name, SUM(payment.amount) AS payments
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY full_name
HAVING SUM(payment.amount) > 175
ORDER BY payments;


--4. List all customers that live in Nepal (use the city table)
-- (I guess we need use country table - Nepal is a country)
SELECT customer.customer_id, CONCAT(customer.first_name, ' ', customer.last_name) AS full_name, country.country
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON city.city_id = address.city_id
JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

-- 5. Which staff member had the most transactions?
SELECT CONCAT(staff.first_name, ' ', staff.last_name) AS staff_full_name, COUNT(payment.payment_id) AS transactions
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff_full_name
ORDER BY transactions DESC;

-- 6. How many movies of each rating are there?
SELECT rating, COUNT(film_id) AS movies
FROM film
GROUP BY rating
ORDER BY movies;

-- 7. Show all customers who have made a single payment 
-- above $6.99 (Use Subqueries)
-- SUBQUERIES
SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS full_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id, amount
    HAVING amount > 6.99
);

-- JOINS (I LIKE JOINS!)
SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS full_name, payment.amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY full_name, payment.amount
HAVING payment.amount > 6.99


-- 8. How many free rentals did our stores give away?
SELECT amount, COUNT(amount) as count_free
FROM payment
GROUP BY amount
HAVING amount =  0