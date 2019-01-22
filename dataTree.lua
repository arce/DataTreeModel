local write = io.write
require "dataVector"
require "CSV"
NULL = -1

function dataTree(id)
  local oid = id or ""
  local fields = {'name','parent','first','next','last','size','height'}
  local table = {}
  local _table = table
  table = {oid=id}
  for _,k in pairs(fields) do
    _table[k] = vector(table.oid..tostring(k))
  end
  local metatable = {
    __newindex = function(table,k,v)
      _table[k] = v
    end,
    __index = function(table,k)
      return _table[k]
    end
  }
  table.nodeNew = function(label,fields)
    local n = table.name.size() + 1
    table.name[n] = label
    table.parent[n] = NULL
    table.first[n] = NULL
    table.next[n] = NULL
    table.last[n] = NULL
    table.size[n] = 0
    table.height[n] = 0
    if fields then
      for k,v in pairs(fields) do
        if table[k] == nil then
          table[k] = vector(table.oid..tostring(k))
        end
        table[k][n] = v
      end
    end
    return n
  end
  function incrHeight(ndx)
    if table.size[ndx] == 1 then
      table.height[ndx] = table.height[ndx] + 1
      if table.parent[ndx] ~= NULL then
        incrHeight(table.parent[ndx])
      end
    end
  end
  table.addChild = function(ndx,label,fields)
    local n = table.nodeNew(label,fields)
    table.parent[n] = ndx
    if table.first[ndx] == NULL then
      table.first[ndx] = n
      table.size[ndx] = 1
      incrHeight(ndx)
    else
      table.next[table.last[ndx]] = n
      table.size[ndx] = table.size[ndx] + 1
    end
    table.last[ndx] = n
    return n
  end
  setmetatable(table,metatable)
  return table
end

function printDataNode(tree,node,fields)
  write(tostring(tree.name[node])..' ')
  if fields then
    for i=1,#fields do
      if tree[fields[i]][node] then
        write(tree[fields[i]][node]..' ')
      end
    end
  end
  write('\n')
  local child = tree.first[node]
  while child ~= NULL do
    printDataNode(tree,child,fields)
    child = tree.next[child]
  end
end

function printDataTree(tree,fields)
  print("oid:",tree.oid)
  printDataNode(tree,0,fields)
end
