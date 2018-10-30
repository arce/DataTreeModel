local DataTree = {}

DataTree = function()
  local table = {name={},parent={},first={},next={},last={}}
  table.nodeNew = function(label,fields)
    local n = #table.name + 1
    table.name[n] = label
    table.parent[n] = 0
    table.first[n] = 0
    table.next[n] = 0
    table.last[n] = 0
    if fields then
      for k,v in pairs(fields) do
        table[k][n]=v
      end
    end
    return n
  end
  table.addChild = function(ndx,label,fields)
   local n = table.nodeNew(label,fields)
    table.parent[n] = ndx
    if table.first[ndx] == 0 then
      table.first[ndx] = n
    else
      table.next[table.last[ndx]] = n
    end
    table.last[ndx] = n
    return n
  end
  return table
end

local tree = DataTree()

function addChild(ndx,label)
  return tree.addChild(ndx,label)
end

function nodeNew(label)
  return tree.nodeNew(label)
end

function printNode(node,fields)
  print(tree.name[node])
  local child = tree.first[node]
  while child ~= 0 do
    printNode(child,fields)
    child = tree.next[child]
  end
end
