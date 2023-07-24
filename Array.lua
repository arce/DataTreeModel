write = io.write

function Array(arg1)
  local table = (type(arg1) == "table") and arg1 or {}
  local _table = table
  table = {}
  local metatable = {
    __newindex = function(table,k,v)
      _table[k+1] = v
    end,
    __index = function(table,k)
      return _table[k+1]
    end
  }
  table.length = function()
    return #_table
  end
  setmetatable(table,metatable)
  return table
end
