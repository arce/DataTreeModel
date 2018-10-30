local DataTree = {}

DataTree = function()
  local table = {_name={},_parent={},_first={},_next={},_last={}}
  local _table = table
  table = {}
  table.nodeNew = function(label,fields)
   local n = #_table._name + 1
    _table._name[n] = label
    _table._parent[n] = 0
    _table._first[n] = 0
    _table._next[n] = 0
    _table._last[n] = 0
    if fields then
      for k,v in pairs(fields) do
        _table[k][n]=v
      end
    end
    return n
  end
  table.addChild = function(ndx,label,fields)
   local n = table.nodeNew(label,fields)
    _table._parent[n] = ndx
    if _table._first[ndx] == 0 then
      _table._first[ndx] = n
    else
      _table._next[_table._last[ndx]] = n
    end
    _table._last[ndx] = n
    return n
  end
  table.name = function(ndx)
    return _table._name[ndx]
  end
  table.parent = function(ndx)
    return _table._parent[ndx]
  end
  table.firstChild = function(ndx)
    return _table._first[ndx]
  end
  table.nextSibling = function(ndx)
    return _table._next[ndx]
  end
  table.lastChild = function(ndx)
    return _table._last[ndx]
  end
  table.name = function(ndx)
    return _table._name[ndx]
  end
  table.field = function(ndx,key,value)
    if value then
      _table[key][ndx] = value
    else
      return _table[key][ndx]
    end
  end
  local metatable = {
    __index = function(table,key)
      return _table[key]
    end,
    __newindex = function(table,key,value)
      _table[key[1]] = value
    end
  }
  setmetatable(table,metatable)
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
  print(tree.name(node))
  local child = tree.firstChild(node)
  while child ~= 0 do
    printNode(child,fields)
    child = tree.nextSibling(child)
  end
end
