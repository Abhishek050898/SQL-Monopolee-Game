-- G6 Norman rolls a 4
-- Initial Loc = 'Chance 1' -> Updated Location = 'Community Chest 1'
-- Balance + 100

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
SET BonusID = ( SELECT ID FROM Bonus WHERE Name = 'Community Chest 1')
WHERE ID = 4;