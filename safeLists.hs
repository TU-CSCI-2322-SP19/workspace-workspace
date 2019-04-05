mHead :: [a] -> Maybe a
mHead [] = Nothing
mHead (x:xs) = Just x

mTail :: [a] -> Maybe [a]
mTail [] = Nothing
mTail (x:xs) = Just xs

thirdElem :: [a] -> Maybe a
thirdElem lst =
  case mTail lst of
    Nothing -> Nothing
    Just tail -> case mTail tail of
                   Nothing -> Nothing
                   Just tail2 = mHead tail2

thirdElemb lst = 
    do lst' <- mTail lst
       lst'' <- mTail lst'
       mHead lst''


twiceFifth :: [Int] -> Maybe Int
twiceFifth lst = 
