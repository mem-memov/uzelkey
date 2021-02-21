module Node 
( Node.Type
, Node.construct
, Node.connect
) where

import qualified EntryStorage.Entry as Entry

data Type = Type Entry.Type

construct :: Entry.Type -> Node.Type
construct entry = Node.Type entry

connect :: Node.Type -> Node.Type -> ()
connect origin target = undefined
