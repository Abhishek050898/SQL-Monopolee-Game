-- G4 Bill rolls a 2
-- Initial Loc = Owens Park -> Updated Location = AMBS
-- Will buy AMBS ( deduct 400 from balance )

UPDATE Players
SET 
	BankBalance = 
	CASE
		WHEN (SELECT count(*) FROM Property 
			WHERE OwnerID = (SELECT OwnerID FROM Property WHERE Name = 'AMBS') 
			AND
			Color = (SELECT Color FROM Property WHERE Name = 'AMBS'))
			=
		  (SELECT count(*) FROM Property WHERE Color = (SELECT Color FROM Property WHERE Name = 'AMBS'))
		THEN BankBalance - (SELECT Cost*2 FROM Property WHERE Name='AMBS')--Doubles cost deduction from Mary's Bank Balance
		ELSE BankBalance - (SELECT Cost FROM Property WHERE Name='AMBS')  -- If No owner then mary will purchase it and deduction will happen.
	END
WHERE ID = 2;

-- CREDIT TO Owner

UPDATE Players
SET BankBalance = CASE
	WHEN (SELECT count(*) FROM Property 
		  WHERE OwnerID = (SELECT OwnerID FROM Property WHERE Name = 'AMBS') 
		  AND
		  Color = (SELECT Color FROM Property WHERE Name = 'AMBS'))
		  =
		  (SELECT count(*) FROM Property WHERE Color = (SELECT Color FROM Property WHERE Name = 'AMBS'))
	THEN BankBalance + (SELECT Cost*2 FROM Property WHERE Name='AMBS')--Doubles cost deduction from Mary's Bank Balance
	ELSE BankBalance + (SELECT Cost FROM Property WHERE Name='AMBS')  -- If No owner then mary will purchase it and deduction will happen.
END
WHERE ID = (SELECT OwnerID FROM Property WHERE Name = 'AMBS');

-- If Property is not owned by any other player, then update the property with new OwnerID
UPDATE Property
SET OwnerID = (SELECT ID FROM Players WHERE Player='Bill')
WHERE Name = 'AMBS' AND OwnerID IS NULL;

UPDATE Players
SET PropertyID = (SELECT ID FROM Property WHERE Name = 'AMBS'),
	BonusID = NULL
WHERE ID = 2;





