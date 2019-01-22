require "dataTree"
local tree = nil
local acme = nil
local f = nil

function drawing(tree,node)
  fill(0)
  rect(tree.x[node]-4,tree.y[node]-4,8,8)
  text(tree.name[node],tree.x[node]+6,tree.y[node])
  local child = tree.first[node]
  while child ~= NULL do
    line(tree.x[node],tree.y[node],tree.x[child],tree.y[child])
    drawing(tree,child)
    child = tree.next[child]
  end
end

function simpleTreeLayout(tree,node,x,y,w,h)
  tree.x[node] = x + w / 2
  tree.y[node] = y
  local child = tree.first[node]
  if child == NULL then
    return
  end
  local xoffset = w / tree.size[node]
  local yoffset = h / tree.height[node]
  local i = 0
  while child ~= NULL do
    simpleTreeLayout(tree,child,x+xoffset*i,y+yoffset,xoffset,h-yoffset)
    child = tree.next[child]
    i = i + 1
  end
end

function setup()
  size(650,520)
  
  textSize(15)
  
  tree = dataTree(1)
  
  acme = tree.nodeNew("Acme Inc.",{x=0,y=0})
    accounting = tree.addChild(acme,"Accounting",{x=0,y=0})
      software = tree.addChild(accounting,"New Software",{x=0,y=0})
      standards = tree.addChild(accounting,"New Accounting",{x=0,y=0})
    research = tree.addChild(acme,"Research",{x=0,y=0})
      newProductLine = tree.addChild(research,"New Product",{x=0,y=0})
      newLabs = tree.addChild(research,"New Labs",{x=0,y=0})
    it = tree.addChild(acme,"IT",{x=0,y=0})
      outsource = tree.addChild(it,"Outsource",{x=0,y=0})
      agile = tree.addChild(it,"Go agile",{x=0,y=0})
      goToR = tree.addChild(it,"Switch to R",{x=0,y=0})

   simpleTreeLayout(tree,acme,10,10,620,460)
end

function draw()
  background(178)
  drawing(tree,acme)
end
