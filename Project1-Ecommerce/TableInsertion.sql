
-- ============================================================
-- SECTION 2: SAMPLE DATA
-- ============================================================

-- Categories
INSERT INTO categories VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Home & Kitchen'),
(4, 'Books'),
(5, 'Sports');

-- Customers
INSERT INTO customers VALUES
(1,  'Aarav Sharma',    'aarav@mail.com',    'Delhi',     'India',  '2022-01-15'),
(2,  'Sara Ahmed',      'sara@mail.com',     'Dubai',     'UAE',    '2022-03-22'),
(3,  'John Carter',     'john@mail.com',     'New York',  'USA',    '2021-11-05'),
(4,  'Lily Zhang',      'lily@mail.com',     'Shanghai',  'China',  '2023-02-10'),
(5,  'Carlos Mendes',   'carlos@mail.com',   'São Paulo', 'Brazil', '2022-07-30'),
(6,  'Priya Nair',      'priya@mail.com',    'Mumbai',    'India',  '2023-05-14'),
(7,  'Emma Wilson',     'emma@mail.com',     'London',    'UK',     '2021-09-01'),
(8,  'Yusuf Al-Amin',   'yusuf@mail.com',    'Cairo',     'Egypt',  '2022-12-20'),
(9,  'Hana Park',       'hana@mail.com',     'Seoul',     'Korea',  '2023-08-08'),
(10, 'Miguel Torres',   'miguel@mail.com',   'Madrid',    'Spain',  '2022-04-17');

-- Products
INSERT INTO products VALUES
(1,  'Wireless Headphones',   1, 89.99,  150),
(2,  'Smart Watch',           1, 199.99, 80),
(3,  'USB-C Hub',             1, 39.99,  200),
(4,  'Men\'s Jacket',         2, 59.99,  120),
(5,  'Women\'s Sneakers',     2, 74.99,  90),
(6,  'Air Fryer',             3, 129.99, 60),
(7,  'Coffee Maker',          3, 89.99,  75),
(8,  'Blender',               3, 49.99,  100),
(9,  'Python Programming',    4, 34.99,  300),
(10, 'Data Science Handbook', 4, 44.99,  250),
(11, 'Yoga Mat',              5, 29.99,  180),
(12, 'Dumbbells Set',         5, 79.99,  50);

-- Orders
INSERT INTO orders VALUES
(1001, 1,  '2024-01-05', 'completed'),
(1002, 2,  '2024-01-12', 'completed'),
(1003, 3,  '2024-01-20', 'returned'),
(1004, 4,  '2024-02-01', 'completed'),
(1005, 5,  '2024-02-14', 'completed'),
(1006, 6,  '2024-02-28', 'pending'),
(1007, 7,  '2024-03-05', 'completed'),
(1008, 8,  '2024-03-18', 'completed'),
(1009, 9,  '2024-04-02', 'completed'),
(1010, 10, '2024-04-15', 'returned'),
(1011, 1,  '2024-04-22', 'completed'),
(1012, 3,  '2024-05-01', 'completed'),
(1013, 5,  '2024-05-10', 'completed'),
(1014, 7,  '2024-05-20', 'completed'),
(1015, 2,  '2024-06-03', 'completed');

-- Order Items
INSERT INTO order_items VALUES
(1, 1001, 1,  2, 89.99),
(2, 1001, 9,  1, 34.99),
(3, 1002, 2,  1, 199.99),
(4, 1002, 3,  2, 39.99),
(5, 1003, 5,  1, 74.99),
(6, 1004, 6,  1, 129.99),
(7, 1004, 7,  1, 89.99),
(8, 1005, 11, 3, 29.99),
(9, 1005, 12, 1, 79.99),
(10,1006, 4,  2, 59.99),
(11,1007, 10, 2, 44.99),
(12,1007, 9,  1, 34.99),
(13,1008, 8,  1, 49.99),
(14,1008, 3,  3, 39.99),
(15,1009, 2,  1, 199.99),
(16,1009, 1,  1, 89.99),
(17,1010, 4,  1, 59.99),
(18,1011, 6,  1, 129.99),
(19,1011, 11, 2, 29.99),
(20,1012, 7,  1, 89.99),
(21,1012, 8,  2, 49.99),
(22,1013, 2,  1, 199.99),
(23,1014, 12, 2, 79.99),
(24,1014, 5,  1, 74.99),
(25,1015, 1,  3, 89.99);

