/*
Clerk, my name’s Anneke. I live over at 900 Somerville Avenue. Not long ago, I sent out a special letter. It’s meant for my friend Varsha. She’s starting a new chapter of her life at 2 Finnegan Street,
uptown. (That address, let me tell you: it was a bit tricky to get right the first time.) The letter is a congratulatory note—a cheery little paper hug from me to her, to celebrate this big move of hers. 
Can you check if it’s made its way to her yet?
*/

-- *** The Lost Letter ***
-- Find the package with the contents "Congratulatory letter" and the from_address_id of 900 Somerville Avenue.
SELECT * FROM packages
WHERE contents = 'Congratulatory letter'
AND from_address_id = (SELECT id FROM addresses WHERE address = '900 Somerville Avenue');
-- Find real name:  2 Finnigan Street
SELECT * from addresses where id = 854;
-- Find the most recent scan for the package found in the previous query.
SELECT * FROM scans
WHERE package_id =
(SELECT id FROM packages WHERE contents = 'Congratulatory letter' AND from_address_id =
(SELECT id FROM addresses WHERE address = '900 Somerville Avenue')) ORDER BY timestamp DESC LIMIT 1;


-- *** The Devious Delivery ***
-- Find all packages that have no "From" address.
SELECT * FROM packages WHERE from_address_id IS NULL;
-- Find all scans associated with the package with the ID of 5098.
SELECT * FROM scans WHERE package_id = 5098;
-- Find the address where the package was last scanned.
SELECT address_id FROM scans WHERE package_id = 5098 ORDER BY timestamp DESC LIMIT 1;
-- Find the address with the ID of 5098. 5098 | 1491 Wharf Street | Business
SELECT * FROM addresses WHERE id = 5098;

-- *** The Forgotten Gift ***
-- Find the package with the tracking information:
SELECT * FROM packages
WHERE from_address_id =
(SELECT id FROM addresses WHERE address = '109 Tileston Street');
-- id 9523 contents Flowers from address 9873 to 4983
-- Find the most recent scan for the package:
SELECT * FROM scans WHERE package_id =
(SELECT id FROM packages WHERE from_address_id =
(SELECT id FROM addresses WHERE address = '109 Tileston Street')
AND to_address_id = (SELECT id FROM addresses WHERE address = '728 Maple Place'))
ORDER BY timestamp DESC LIMIT 1;
-- driver 17 action pick

/*

At what type of address did the Lost Letter end up?: Residential
At what address did the Lost Letter end up?: 2 Finnigan Street

At what type of address did the Devious Delivery end up?: Business
What were the contents of the Devious Delivery?: Duck

What are the contents of the Forgotten Gift?: Flowers
Who has the Forgotten Gift?: Pick

*/

