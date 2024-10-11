-- G8 Bill rolls a 6, and then a 3
-- Rule: R5 If a player rolls a 6, they move 6 squares; whatever location they land on has no effect. They then get another roll 
-- immediately.
-- Intial location: AMBS --- Updated Location after 9 steps: Community Chest 1
-- Balance: Balance + 200(passing GO) + 100(Chest reward)

DROP TRIGGER IF EXISTS CommunityChest;
CREATE TRIGGER CommunityChest
BEFORE UPDATE of BonusID on Players
WHEN NEW.BonusID = (SELECT ID FROM Bonus WHERE Name='Community Chest 1')
BEGIN
	UPDATE Players
	SET BankBalance = BankBalance + 100
	WHERE ID = NEW.ID;
END;

UPDATE Players
SET BankBalance = BankBalance + 200 -- Passing GO so +200
WHERE ID = 2;

UPDATE Players
SET BonusID = (SELECT ID FROM Bonus WHERE Name='Community Chest 1'),
	PropertyID = NULL	
WHERE ID = 2;