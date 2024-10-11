-- G3 Mary rolls a 4
-- Initial Loc = Free Parking -> Updated Location = Go to Jail

UPDATE Players
SET BonusID = (SELECT ID FROM Bonus WHERE Name = 'Go to Jail'),
	PropertyID = NULL
WHERE ID = 1;
