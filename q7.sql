-- G7 Mary rolls a 6, and then a 5
-- She moves 6 steps, but as per rule no changes on 6. 
-- Further after 5 steps she lands on Oak House
-- Initial Loc = 'Jail' -> Updated Location = 'Oak House'( orange is all owned by Player 4 )
-- deduct double cost of location from Mary and credit to Norman (Owner)

UPDATE Players
SET 
	BankBalance = 
	CASE
		WHEN (SELECT count(*) FROM Property 
			WHERE OwnerID = (SELECT OwnerID FROM Property WHERE Name = 'Oak House') 
			AND
			Color = (SELECT Color FROM Property WHERE Name = 'Oak House'))
			=
		  (SELECT count(*) FROM Property WHERE Color = (SELECT Color FROM Property WHERE Name = 'Oak House'))
		THEN BankBalance - (SELECT Cost*2 FROM Property WHERE Name='Oak House')--Doubles cost deduction from Mary's Bank Balance
		ELSE BankBalance - (SELECT Cost FROM Property WHERE Name='Oak House')  -- If No owner then mary will purchase it and deduction will happen.
	END
WHERE ID = 1;

-- CREDIT TO Owner

UPDATE Players
SET 
	BankBalance = 
	CASE
		WHEN (SELECT count(*) FROM Property 
			WHERE OwnerID = (SELECT OwnerID FROM Property WHERE Name = 'Oak House') 
			AND
			Color = (SELECT Color FROM Property WHERE Name = 'Oak House'))
			=
		  (SELECT count(*) FROM Property WHERE Color = (SELECT Color FROM Property WHERE Name = 'Oak House'))
		THEN BankBalance + (SELECT Cost*2 FROM Property WHERE Name='Oak House')--Doubles cost deduction from Mary's Bank Balance
		ELSE BankBalance + (SELECT Cost FROM Property WHERE Name='Oak House')  -- If No owner then mary will purchase it and deduction will happen.
	END
WHERE ID = (SELECT OwnerID FROM Property WHERE Name = 'Oak House');

-- If Property is not owned by any other player, then update the property with new OwnerID
UPDATE Property
SET OwnerID = (SELECT ID FROM Players WHERE Player='Mary')
WHERE Name = 'Oak House' AND OwnerID IS NULL;

UPDATE Players
SET PropertyID = (SELECT ID FROM Property WHERE Name = 'Oak House'),
	BonusID = NULL
WHERE ID = 1;


