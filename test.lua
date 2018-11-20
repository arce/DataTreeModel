require "dataTree"

-- Create a tree programmatically

local tree1 = dataTree()
acme = tree1.nodeNew("Acme Inc.")
  accounting = tree1.addChild(acme,"Accounting")
    software = tree1.addChild(accounting,"New Software")
    standards = tree1.addChild(accounting,"New Accounting Standards")
  research = tree1.addChild(acme,"Research")
    newProductLine = tree1.addChild(research,"New Product Line")
    newLabs = tree1.addChild(research,"New Labs")
  it = tree1.addChild(acme,"IT")
    outsource = tree1.addChild(it,"Outsource")
    agile = tree1.addChild(it,"Go agile")
    goToR = tree1.addChild(it,"Switch to R")
    
printDataTree(tree1)

print()

-- Custom fields in constructor

local tree2 = dataTree()
birds = tree2.nodeNew("Aves", {vulgo = "Bird"})
tree2.addChild(birds,"Neognathae", {vulgo = "New Jaws", species = 10000})
tree2.addChild(birds,"Palaeognathae", {vulgo = "Old Jaws", species = 60})

printDataTree(tree2, {'vulgo', 'species'})
