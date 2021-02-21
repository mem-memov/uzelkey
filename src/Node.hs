module Node 
( Node.Type
, Node.construct
, Node.connect
) where

import qualified Entry

data Type = Type Entry.Type

construct :: Entry.Type -> Node.Type
construct entry = Node.Type entry

connect :: Node.Type -> Node.Type -> ()
connect origin target = undefined
