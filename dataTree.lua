

function nodeNew(label,fields)
  local node = {members=0,height=0,count=0,name=label,leaf=true}
  if fields then
    for k,v in pairs(fields) do
      node[k]=v
    end
  end
  return node
end

function addChild(node,name,fields)
  local n = #node + 1
  local child = nodeNew(name,fields)
  node[n] = child
  node[name]= child
  node.leaf=false
  node.count = node.count + 1
  return child
end

function printN(node,fields)
end

function asNode(dataFrame)
end

function clone(node)
end

function merge(node1,node2)
end
