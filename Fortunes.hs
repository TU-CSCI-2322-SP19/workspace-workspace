main = do
    fortuneText <- readFile "fortunes.txt"
    let fortunes = lines fortuneText
    putStr "What is your name? "
    name <- getLine
    putStr $ "Welcome " ++ name ++ ". Please give me a number: "
    index <- getLine
    putStrLn $ "Your fortune: " ++ fortunes `at` (read index) 

at :: [a] -> Int -> a
--at lst index = lst !! (index `mod` (length lst))
at lst index = (cycle lst) !! index
    
