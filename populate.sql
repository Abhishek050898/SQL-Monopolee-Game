INSERT INTO Bonus(ID,Name,Description)
VALUES
(1,"Chance 1","Pay each of the other players £50"),
(2,"Chance 2","Move forward 3 spaces"),
(3,"Community Chest 1","For winning a Beauty Contest, you win £100"),
(4,"Community Chest 2","Your library books are overdue. Play a fine of £30"),
(5,"Free Parking","No action"),
(6,"Go to Jail","Go to Jail, do not pass GO, do not collect £200"),
(7,"GO","Collect £200");

INSERT INTO Token(ID,Name)
VALUES
(1,"Battleship"),
(2,"Dog"),
(3,"Top Hat"),
(4,"Car"),
(5,"Thimble"),
(6,"Boot");

INSERT INTO Property(ID,Name,Cost,Color,OwnerID)
VALUES
(1,"Oak House",100,"Orange",NULL),
(2,"Owens Park",30,"Orange",NULL),
(3,"AMBS",400,"Blue",NULL),
(4,"Co-op",30,"Blue",NULL),
(5,"Kilburn",120,"Yellow",NULL),
(6,"Uni Place",100,"Yellow",NULL),
(7,"Victoria",75,"Green",NULL),
(8,"Piccadilly",35,"Green",NULL);


INSERT INTO Players(ID,Player,Token,BankBalance,PropertyID,BonusID)
VALUES
(1,"Mary","Battleship",190,NULL,5),
(2,"Bill","Dog",500,2,NULL),
(3,"Jane","Car",150,3,NULL),
(4,"Norman","Thimble",250,5,NULL);


UPDATE Property
SET OwnerID = 4
WHERE ID = 1;

UPDATE Property
SET OwnerID = 4
WHERE ID = 2;

UPDATE Property
SET OwnerID = 3
WHERE ID = 4;

UPDATE Property
SET OwnerID = 1
WHERE ID = 6;

UPDATE Property
SET OwnerID=2
WHERE ID=7;

