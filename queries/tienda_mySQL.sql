/*1*/-- List the name of all the products in the product table 
SELECT nombre FROM producto;

/*2*/-- List the names and prices of all the products in the product table
SELECT nombre, producto.precio FROM producto;

/*3*/-- List all columns of the product table 
DESCRIBE producto;

/*4*/-- List the name of the products, the price in euros and the price in US dollars (USD)
SELECT nombre, precio AS precio_€, TRUNCATE(producto.precio * 1.0685, 2) AS precio_USD FROM producto;

/*5*/-- List the name of the products, the price in euros and the price in US dollars (USD). Use the following aliases for the columns: product name, euros, dollars
SELECT nombre AS 'nom de producto', precio AS euros, TRUNCATE(producto.precio * 1.0685, 2) AS dòlars FROM producto;

/*6*/-- List the names and prices of all products in the product table, converting the names to uppercase
SELECT upper(nombre) AS producto, precio FROM producto;

/*7*/-- List the names and prices of all products in the product table, converting the names to lowercase
SELECT lower(nombre) AS producto, precio FROM producto;

/*8*/-- List the name of all manufacturers in one column, and in another column capitalize the first two characters of the manufacturer's name
SELECT nombre, upper(SUBSTRING(nombre, 1,2)) AS iniciales FROM fabricante;

/*9*/-- List the names and prices of all products in the product table, rounding the price value
SELECT nombre AS producto, round(precio) AS 'precio redondeado' FROM producto;

/*10*/-- List the names and prices of all products in the product table, truncating the price value to display it without any decimal places
SELECT nombre AS producto, TRUNCATE(producto.precio, 0) AS 'precio truncado' FROM producto;

/*11*/-- List the code of the manufacturers that have products in the product table
SELECT codigo_fabricante FROM producto;

/*12*/-- List the code of the manufacturers that have products in the product table, eliminating the codes that appear repeatedly
SELECT DISTINCT codigo_fabricante FROM producto;

/*13*/-- List manufacturer names in ascending order
SELECT nombre FROM fabricante ORDER BY nombre;

/*14*/-- List manufacturer names in descending order
SELECT nombre FROM fabricante ORDER BY nombre DESC;

/*15*/-- Lists product names sorted first by name in ascending order and second by price in descending order
SELECT nombre AS 'producto (ordenado alfabetico)' FROM producto ORDER BY nombre;
SELECT nombre AS 'producto (ordenado precio desc)'FROM producto ORDER BY precio DESC;

/*16*/-- Returns a list with the first 5 rows of the manufacturer table
SELECT * FROM fabricante LIMIT 5;

/*17*/-- Returns a list with 2 rows starting from the fourth row of the manufacturer table. The fourth row must also be included in the answer
SELECT * FROM fabricante LIMIT 3, 2;

/*18*/-- List the cheapest product name and price. (Use only the ORDER BY and LIMIT clauses). NOTE: I could not use MIN(price) here
SELECT nombre, precio FROM producto ORDER BY precio LIMIT 1;

/*19*/-- List the name and price of the most expensive product. (Use only the ORDER BY and LIMIT clauses). NOTE : I could not use MAX(price) here
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

/*20*/-- List the name of all products from the manufacturer whose manufacturer code is equal to 2
SELECT nombre AS producto FROM producto WHERE codigo_fabricante = 2;

/*21*/-- Returns a list with the product name, price, and manufacturer name of all products in the database
SELECT p.nombre AS producto, precio, f.nombre AS fabricante FROM producto AS p, fabricante AS f WHERE p.codigo_fabricante = f.codigo;

/*22*/-- Returns a list with the product name, price, and manufacturer name of all products in the database. Sort the result by manufacturer name, in alphabetical order
SELECT p.nombre AS producto, precio, f.nombre AS fabricante FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre;

/*23*/-- Returns a list with the product code, product name, manufacturer code, and manufacturer name of all products in the database
SELECT p.codigo AS codigo_producto, p.nombre AS producto, p.codigo_fabricante, f.nombre AS fabricante FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo;

/*24*/-- Returns the name of the product, its price and the name of its manufacturer, of the cheapest product
SELECT p.nombre AS producto, precio, f.nombre AS fabricante FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo WHERE precio = (SELECT MIN(precio) FROM producto);

/*25*/-- Returns the name of the product, its price and the name of its manufacturer, of the most expensive product
SELECT p.nombre AS producto, precio, f.nombre AS fabricante FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo WHERE precio = (SELECT MAX(precio) FROM producto);

/*26*/-- Returns a list of all products from manufacturer Lenovo
SELECT nombre FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');

/*27*/-- Returns a list of all products from manufacturer Crucial that have a price greater than €200
SELECT nombre FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Crucial') AND precio > 200;

/*28*/-- Returns a list with all products from manufacturers Asus, Hewlett-Packard and Seagate. Without using the IN operator
SELECT nombre FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus') OR codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Hewlett-Packard') OR codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Seagate');

/*29*/-- Returns a list with all products from manufacturers Asus, Hewlett-Packard and Seagate. Using the IN operator
SELECT nombre FROM producto WHERE codigo_fabricante IN (SELECT codigo FROM fabricante WHERE nombre = 'Asus' OR nombre = 'Hewlett-Packard' OR nombre = 'Seagate');

/*30*/-- Returns a list with the name and price of all products from manufacturers whose name ends with the vowel e
SELECT nombre, precio FROM producto WHERE codigo_fabricante IN (SELECT codigo FROM fabricante WHERE nombre LIKE '%e');

/*31*/-- Returns a list with the name and price of all products whose manufacturer name contains the character w in their name
SELECT nombre, precio FROM producto WHERE codigo_fabricante IN (SELECT codigo FROM fabricante WHERE nombre LIKE '%w%');

/*32*/-- Returns a list with the product name, price and manufacturer name, of all products that have a price greater than or equal to €180. Sort the result first by price (in descending order) and second by name (in ascending order)
SELECT p.nombre AS producto, precio, f.nombre FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo WHERE precio >= 180 ORDER BY precio DESC;
SELECT p.nombre AS producto, precio, f.nombre FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo WHERE precio >= 180 ORDER BY p.nombre;

/*33*/-- Returns a list with the manufacturer's code and name, only of those manufacturers that have associated products in the database
SELECT codigo, nombre AS fabricante FROM fabricante WHERE codigo IN (SELECT DISTINCT codigo_fabricante FROM producto);

/*34*/-- Returns a list of all the manufacturers that exist in the database, along with the products that each of them has. The list must also show those manufacturers that do not have associated products
SELECT f.nombre AS fabricante, p.nombre AS producto FROM fabricante AS f LEFT JOIN producto AS p ON p.codigo_fabricante = f.codigo ORDER BY f.nombre;

/*35*/-- Returns a list showing only those manufacturers that do not have any associated products
SELECT f.nombre AS fabricante, p.nombre AS producto FROM fabricante AS f LEFT JOIN producto AS p ON p.codigo_fabricante = f.codigo WHERE p.nombre IS NULL;

/*36*/-- Returns all products from the manufacturer Lenovo. (Without using INNER JOIN)
SELECT nombre FROM producto WHERE codigo_fabricante = (SELECT codigo from fabricante WHERE nombre = 'Lenovo');

/*37*/-- Returns all data for products that have the same price as the most expensive product from the manufacturer Lenovo. (Without using INNER JOIN)
SELECT * FROM producto WHERE precio = (SELECT max(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo from fabricante WHERE nombre = 'Lenovo'));

/*38*/-- List the name of the most expensive product from the manufacturer Lenovo.
SELECT p.nombre FROM producto AS p INNER JOIN fabricante AS f ON  p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo' ORDER BY p.precio DESC LIMIT 1;

/*39*/-- List the cheapest product name from the manufacturer Hewlett-Packard
SELECT p.nombre FROM producto AS p INNER JOIN fabricante AS f ON  p.codigo_fabricante = f.codigo WHERE f.nombre = 'Hewlett-Packard' ORDER BY p.precio LIMIT 1;

/*40*/-- Returns all products in the database that have a price greater than or equal to the most expensive product from manufacturer Lenovo
SELECT nombre FROM producto WHERE precio >= (SELECT max(precio) FROM producto AS p INNER JOIN fabricante AS f ON  p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo');

/*41*/-- List all products from the manufacturer Asus that are priced higher than the average price of all their products
SELECT nombre FROM producto WHERE precio >= (SELECT AVG(precio) FROM producto AS p INNER JOIN fabricante AS f ON  p.codigo_fabricante = f.codigo WHERE f.nombre = 'Asus');

