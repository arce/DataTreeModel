local write = io.write

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
        if table[k] == nil then
          table[k] = {}
        end
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

function addChild(ndx,label,fields)
  return tree.addChild(ndx,label,fields)
end

function nodeNew(label,fields)
  return tree.nodeNew(label,fields)
end

function printNode(node,fields)
  write(tree.name[node]..' ')
  if fields then
    for i=1,#fields do
      if tree[fields[i]][node] then
        write(tree[fields[i]][node]..' ')
      end
    end
  end
  write('\n')
  local child = tree.first[node]
  while child ~= 0 do
    printNode(child,fields)
    child = tree.next[child]
  end
end
