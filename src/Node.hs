module Node 
( Node.Type
, Node.construct
, Node.connect
) where

import qualified Types

data Type = Type Types.Entry 

construct :: Types.Entry -> Node.Type
construct entry = Node.Type entry

connect :: Node.Type -> Node.Type -> ()
connect origin target = undefined
