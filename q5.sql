-- Jane rolls a 5
-- Initial Loc = GO -> Updated Location = Victoria ( Already purchased by player 2 )
-- pay rent of 75 to player 2

DROP TRIGGER IF EXISTS UpdateAudit;
CREATE TRIGGER UpdateAudit
AFTER UPDATE OF PropertyID,BonusID ON Players
WHEN 
(NEW.BankBalance != OLD.BankBalance) 
or (NEW.BonusID IS NULL AND OLD.BonusID IS NOT NULL)
or (NEW.BonusID IS NOT NULL AND OLD.BonusID IS NULL)
or (NEW.PropertyID IS NULL AND OLD.PropertyID IS NOT NULL)
or (NEW.PropertyID IS NOT NULL AND OLD.PropertyID IS NULL)
or (NEW.BonusID != OLD.BonusID) 
or (NEW.PropertyID != OLD.PropertyID)
BEGIN
    INSERT INTO Audit (PlayerID,Updated_Balance,PropertyID,BonusID,GameRound)
    VALUES (NEW.ID, NEW.BankBalance,NEW.PropertyID,NEW.BonusID, 2);
END;


UPDATE Property
SET OwnerID = CASE
    WHEN (SELECT OwnerID FROM Property WHERE Name = 'Victoria') IS NULL THEN
        3 
    ELSE
        OwnerID
    END
WHERE Name = 'Victoria';

UPDATE Players
SET PropertyID = (SELECT ID FROM Property WHERE Name = 'Victoria'),
	BonusID = NULL,
	BankBalance = BankBalance - (SELECT Cost FROM Property WHERE Name = 'Victoria')
WHERE ID = 3;

UPDATE Players
SET BankBalance = BankBalance + (SELECT Cost FROM Property WHERE Name = 'Victoria')
WHERE ID = 2;

	