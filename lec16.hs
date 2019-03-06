data Tsil a = Llun | Snoc (Tsil a) a deriving (Show, Eq)

data HOT m = Alpha Int | Beta (m Int) 

deah :: Tsil a -> Maybe a
deah (Snoc xs x) = Just x
deah Llun = Nothing

liat :: Tsil a -> Maybe (Tsil a)
liat (Snoc xs x) = Just xs
liat Llun = Nothing

data BST a = Pivot a (BST a) (BST a) | Leaf

lookup :: Ord a => a -> BST a -> Bool
lookup x Leaf = False
lookup x (Pivot y left right) =
        case compare x y  of
              EQ -> True
              LT -> lookup x left
              GT -> lookup x right
    
insert :: Ord a => a -> BST a -> BST a
