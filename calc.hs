str = "7 + 232 - 3 * 4"
wordedStr = words str

data Op = Plus | Mult | Div | Minus deriving Show
data Token = ValueT Int | OperT Op deriving Show

tokenStr = [ValueT 7, OperT Plus, ValueT 232, OperT Minus, ValueT 3, OperT Mult, ValueT 4]

lexer :: String -> Maybe Token
lexer "+" = Just $ OperT Plus
lexer "-" = Just $ OperT Minus
lexer "*" = Just $ OperT Mult
lexer "/" = Just $ OperT Div
lexer num = if (and [x `elem` ['0'..'9'] | x <- num])
            then Just $ ValueT (read num)
            else Nothing
            --make this support negatives!

dangerlex :: String -> Token
dangerlex "+" = OperT Plus
dangerlex "-" = OperT Minus
dangerlex "*" = OperT Mult
dangerlex "/" = OperT Div
dangerlex num = if and [x `elem` ['0'..'9'] | x <- num]
            then ValueT (read num)
            else error $ "Invalid token type: " ++ num

            
data ParseTree = ValueNode Int
               | OperNode Op ParseTree ParseTree
               deriving Show

parsedStr = OperNode Minus (OperNode Plus (ValueNode 7) 
                                          (ValueNode 2)
                           ) 
                           (OperNode Mult (ValueNode 3)
                                          (ValueNode 4)
                           )

unlex :: [Token] -> String
unlex = undefined

eval :: ParseTree -> ???
eval = undefined 

parse :: [Token] -> ParseTree
parse = undefined
