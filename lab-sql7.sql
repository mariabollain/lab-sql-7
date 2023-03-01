USE sakila;

# In the table actor, which are the actors whose last names are not repeated? For example if you would sort the data in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. These three actors have the same last name. So we do not want to include this last name in our output. Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.

SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;

SELECT first_name, last_name, COUNT(last_name) OVER (PARTITION BY last_name) FROM actor
WHERE COUNT(last_name) = 1;

# Which last names appear more than once? We would use the same logic as in the previous question but this time we want to include the last names of the actors where the last name was present more than once

SELECT last_name, COUNT(first_name) FROM actor
GROUP BY last_name
HAVING COUNT(first_name) > 1
ORDER BY COUNT(first_name) DESC;

# Using the rental table, find out how many rentals were processed by each employee.

SELECT staff_id, COUNT(rental_id) AS num_of_rentals FROM rental
GROUP BY staff_id;

SELECT DISTINCT staff_id, COUNT(rental_id) OVER (PARTITION BY staff_id) AS num_of_rentals FROM rental;

# Using the film table, find out how many films were released each year.

SELECT release_year, COUNT(film_id) AS num_of_films FROM film
GROUP BY release_year;

SELECT DISTINCT release_year, COUNT(film_id) OVER (PARTITION BY release_year) AS num_of_films FROM film;

# Using the film table, find out for each rating how many films were there.

SELECT rating, COUNT(film_id) AS num_of_films FROM film
GROUP BY rating
ORDER BY num_of_films;

# What is the mean length of the film for each rating type. Round off the average lengths to two decimal places

SELECT rating, ROUND(AVG(length), 2) AS mean_length FROM film
GROUP BY rating;

# Which kind of movies (rating) have a mean duration of more than two hours?

SELECT rating, ROUND(AVG(length), 2) AS mean_length FROM film
GROUP BY rating
HAVING mean_length > 120;

