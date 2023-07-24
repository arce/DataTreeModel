--
-- DataTree.lua
--
-- DataTreeModel - Simple Toolkit for Information Visualization
--
-- Copyright (c) 2018-2019 Armando Arce - arce@tec.ac.cr
--
-- This library is free software; you can redistribute it and/or modify
-- it under the terms of the MIT license. See LICENSE for details.
--

require "DataTreeCore"

function compute(self,field,fn,flag)
  addField(self,field)
  setField(self,field,0,totalCount(self))
  traversal(self,root(self),fn,flag)
end

function computeHeight(self)
  compute(self,'height',
    function(node,child)
      self.height[node] = math.max((self.height[node] or 0),self.height[child]+1)
    end)
end

function computeBreadth(self)
  compute(self,'breadth',
    function(node,child)
      if self.breadth[child]==0 then
        self.breadth[node] = (self.breadth[node] or 0) + 1
      else
        self.breadth[node] = (self.breadth[node] or 0) + self.breadth[child]
      end
    end)
end

function computeDegree(self)
  compute(self,'degree',
    function(node,child)
      self.degree[node] = (self.degree[node] or 0) + (self.degree[child] or 0) + 1
    end)
end

function computeLevel(self)
  compute(self,'level',
    function(node,child)
      self.level[child] = self.level[node] + 1
    end,true)
end

function _createRegularTree(self,node,level,branches)
  if (level==0) then return end
  local child = NULL
  for i=0,branches-1 do
    child = addChild(self,node,tostring(node))
    _createRegularTree(self,child,level-1,branches)
  end
end

function createRegularTree(level,branches)
  local tree = DataTree()
  local root = newNode(tree,'0')
  _createRegularTree(tree,root,level,branches)
  return tree
end
