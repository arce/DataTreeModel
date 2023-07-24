--
-- DataTreeCore.lua
--
-- DataTreeModel - Simple Toolkit for Information Visualization
--
-- Copyright (c) 2018-2019 Armando Arce - arce@tec.ac.cr
--
-- This library is free software; you can redistribute it and/or modify
-- it under the terms of the MIT license. See LICENSE for details.
--

require "Class"
require "Array"

DataTree = Class()

NULL = -1

function DataTree:__init()
  self.label = Array()
  self._parent = Array()
  self._first = Array()
  self._next = Array()
  self._last = Array()
  self._count = Array()
  self._totalCount = 0
  self._root = 0
end

function root(self)
  return self._root
end

function totalCount(self)
  return self._totalCount
end

function parent(self,node)
  return self._parent[node]
end

function count(self,node)
  return self._count[node]
end

function newNode(self,label)
  local n = self._totalCount
  self.label[n] = label
  self._totalCount = self._totalCount + 1
  self._parent[n],self._first[n] = NULL,NULL
  self._next[n],self._last[n] = NULL,NULL
  self._count[n] = 0
  return n
end

function addChild(self,node,label)
  local n = newNode(self,label)
  self._parent[n] = node
  if (self._first[node] == NULL) then
    self._first[node] = n
    self._count[node] = 1
  else
    self._next[self._last[node]] = n
    self._count[node] = self._count[node] + 1
  end
  self._last[node] = n
  return n
end

function addField(self,name)
  self[name] = Array()
end

function setField(self,field,value,num)
  for i = 0,num-1 do
    self[field][i] = value
  end
end

function fieldNames(self)
  local fields = {}
  for field in pairs(self) do
    if string.sub(field,0,1) ~= "_" then
      table.insert(fields,field)
    end
  end
  return fields
end

function traversal(self,node,fn,flag)
  local child = self._first[node]
  while child ~= NULL do
    if flag then
      fn(node,child)
      traversal(self,child,fn,flag)
    else
      traversal(self,child,fn,flag)
      fn(node,child)
    end
    child = self._next[child]
  end
end

function _writeln(self,node,level,fields)
  write(string.rep(' ', level))
  write(self.label[node])
  if fields then
    for _,field in pairs(fields) do
      write(" ", self[field][node])
    end
  end
  write('\n')
  local child = self._first[node]
  while child ~= NULL do
    _writeln(self,child,level+1,fields)
    child = self._next[child]
  end
end

function writeln(self,fields,node)
  if node == nil then
    node = self._root
  end
  _writeln(self,node,0,fields)
end
