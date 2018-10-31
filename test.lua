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
    
printNode(acme)

-- Custom fields in constructor

birds = nodeNew("Aves", {vulgo = "Bird"})
addChild(birds,"Neognathae", {vulgo = "New Jaws", species = 10000})
addChild(birds,"Palaeognathae", {vulgo = "Old Jaws", species = 60})

printNode(birds, {'vulgo', 'species'})
