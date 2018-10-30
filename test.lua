require "dataTree"

-- Create a tree programmatically

acme = nodeNew("Acme Inc.")
  accounting = addChild(acme,"Accounting")
    software = addChild(accounting,"New Software")
    standards = addChild(accounting,"New Accounting Standards")
  research = addChild(acme,"Research")
    newProductLine = addChild(research,"New Product Line")
    newLabs = addChild(research,"New Labs")
  it = addChild(acme,"IT")
    outsource = addChild(it,"Outsource")
    agile = addChild(it,"Go agile")
    goToR = addChild(it,"Switch to R")

printN(acme)

-- Navigation by path

print(acme.IT.Outsource.name)

print(acme.Research['New Labs'].name)

-- Naviation by position

print(acme[1][2].name)

-- Custom fields

acme.Accounting['New Software'].cost = 1000000
acme.Accounting["New Accounting Standards"].cost = 500000
acme.Research["New Product Line"].cost = 2000000
acme.Research["New Labs"].cost = 750000
acme.IT.Outsource.cost = 400000
acme.IT["Go agile"].cost = 250000
acme.IT["Switch to R"].cost = 50000

acme.Accounting["New Software"].p = 0.5
acme.Accounting["New Accounting Standards"].p = 0.75
acme.Research["New Product Line"].p = 0.25
acme.Research["New Labs"].p = 0.9
acme.IT.Outsource.p = 0.2
acme.IT["Go agile"].p = 0.05
acme.IT["Switch to R"].p = 1

printN(acme,{"cost","p"})

-- Custom fields in constructor

birds = nodeNew("Aves", {vulgo = "Bird"})
addChild(birds,"Neognathae", {vulgo = "New Jaws", species = 10000})
addChild(birds,"Palaeognathae", {vulgo = "Old Jaws", species = 60})
printN(birds, "vulgo", "species")
