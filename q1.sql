--  G1 Jane rolls a 3
-- Initial Loc = AMBS -> Updated Location = GO
-- Add 200 to balance

DROP TRIGGER IF EXISTS UpdateAudit;

CREATE TRIGGER UpdateAudit
AFTER UPDATE OF BonusID,PropertyID ON Players
WHEN (NEW.BankBalance != OLD.BankBalance) 
or (NEW.BonusID IS NULL AND OLD.BonusID IS NOT NULL)
or (NEW.BonusID IS NOT NULL AND OLD.BonusID IS NULL)
or (NEW.PropertyID IS NULL AND OLD.PropertyID IS NOT NULL)
or (NEW.PropertyID IS NOT NULL AND OLD.PropertyID IS NULL)
or (NEW.BonusID != OLD.BonusID) 
or (NEW.PropertyID != OLD.PropertyID) 

BEGIN
    INSERT INTO Audit (PlayerID,Updated_Balance,PropertyID,BonusID,GameRound)
    VALUES (NEW.ID, NEW.BankBalance,NEW.PropertyID,NEW.BonusID, 1);
END;

UPDATE Players
SET BonusID = (SELECT ID FROM Bonus WHERE Name = 'GO'),
	BankBalance = BankBalance + 200,
	PropertyID = NULL
WHERE ID = 3;




