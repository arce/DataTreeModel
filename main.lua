require "dataTree"

local xoffset = 10
local yoffset = 10
local tree = nil

function drawing(tree,node)
  rect(tree.x[node]-4,tree.y[node]-4,8,8)
  text(tree.name[node],tree.x[node]+6,tree.y[node])
  local child = tree.first[node]
  while child ~= 0 do
    line(tree.x[node],tree.y[node],tree.x[child],tree.y[child])
    drawing(tree,child)
    child = tree.next[child]
  end
end

function simpleTreeLayout(tree,node,x,y,w,h)
  tree.x[node] = x + w / 2
  tree.y[node] = y
  local child = tree.first[node]
  if child == 0 then
    return
  end
  local xoffset = w / tree.size[node]
  local yoffset = h / tree.height[node]
  local i = 0
  while child ~= 0 do
    simpleTreeLayout(tree,child,x+xoffset*i,y+yoffset,xoffset,h-yoffset)
    child = tree.next[child]
    i = i + 1
  end
end

function setup()
  size(650,520)
  background(178)
  f = createFont("data/Vera.ttf",13)
  textFont(f)
  
  tree = dataTree()
  
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

  simpleTreeLayout(tree,1,10,10,620,460)
end

function draw()
  drawing(tree,1)
end
