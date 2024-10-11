-- G2 Norman rolls a 1
-- Initial Loc = Kilburn -> Updated Location = Chance 1
-- Give every other player 50 pounds

CREATE TRIGGER Chance1
BEFORE UPDATE of BonusID on Players
WHEN NEW.BonusID = (SELECT ID FROM Bonus WHERE Name='Chance 1')
BEGIN
	UPDATE Players
	SET BankBalance = BankBalance - (50 * ((SELECT COUNT(*) FROM Players) - 1))
	WHERE ID = NEW.ID;
	
	UPDATE Players
	SET BankBalance = BankBalance + 50
	WHERE ID != NEW.ID;
END;

UPDATE Players
SET BonusID = (SELECT ID FROM Bonus WHERE Name = 'Chance 1'),
    PropertyID = NULL
WHERE ID = 4;
