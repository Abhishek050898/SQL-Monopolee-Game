DROP VIEW IF EXISTS gameView;

CREATE VIEW gameView AS
SELECT
	p.ID AS Player_ID,
	p.Player AS Player_Name,
	prop.Name AS Property_Location,
	b.Name AS Bonus_Location,
	p.BankBalance AS Bank_Balance,
	group_concat(pr.Name,',') AS Properties_Owned,
	(Select MAX(a.GameRound) FROM Audit a WHERE a.PlayerID = p.ID)AS Game_Round
FROM Players p
LEFT JOIN Property prop on prop.ID = p.PropertyID
LEFT JOIN Property pr ON pr.OwnerID = p.ID
LEFT JOIN Bonus b on p.BonusID = b.ID
GROUP BY pr.OwnerID
ORDER BY Bank_Balance DESC;

