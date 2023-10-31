-- Ingredients Table
CREATE TABLE Ingredients (
    ingredient_id INTEGER PRIMARY KEY,
    ingredient_name TEXT NOT NULL,
    price_per_unit REAL NOT NULL
);

-- Donuts Table
CREATE TABLE Donuts (
    donut_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    is_gluten_free BOOLEAN NOT NULL,
    price_per_donut REAL NOT NULL
);

-- DonutIngredients Table
CREATE TABLE DonutIngredients (
    donut_id INTEGER,
    ingredient_id INTEGER,
    FOREIGN KEY (donut_id) REFERENCES Donuts(donut_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id)
);

-- Customers Table
CREATE TABLE Customers (
    customer_id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL
);

-- Orders Table
CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    order_id INTEGER,
    donut_id INTEGER,
    quantity INTEGER,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (donut_id) REFERENCES Donuts(donut_id)
);

