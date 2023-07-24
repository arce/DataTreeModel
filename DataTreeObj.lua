--
-- DataTreeObj.lua
--
-- DataTreeModel - Simple Toolkit for Information Visualization
--
-- Copyright (c) 2018-2019 Armando Arce - arce@tec.ac.cr
--
-- This library is free software; you can redistribute it and/or modify
-- it under the terms of the MIT license. See LICENSE for details.
--

require "DataTree"

function DataTree:newNode(label)
  return newNode(self,label)
end

function DataTree:addChild(node,label)
  return addChild(self,node,label)
end

function DataTree:addField(name)
  addField(self,name)
end

function DataTree:setField(field,value,num)
  setField(self,field,value,num)
end

function DataTree:setValue(field,node,value)
  self[field][node] = value
end

function DataTree:getValue(field,node)
  return self[field][node]
end

function DataTree:getRoot()
  return getRoot(self)
end

function isRoot(self,node)
  return (self.parent[node] == NULL)
end

function DataTree:print()
  printTree(self,self.root)
end
