main = do fortuneText <- readFile "fortunes.txt"
          let fortunes = lines fortuneText
          name <- prompt "What is your name? "
          putStr $ "Welcome " ++ name ++ "."
          tellFortune fortunes

prompt :: String -> IO String
prompt str = do
  putStr str
  anwer <- getLine
  return anwer

tellFortune :: [String] -> IO ()
tellFortune fortunes = do
  answer <- prompt "Do you want a fortune?"
  if answer == "yes"
  then do index <- prompt "Please give me a number: "
          putStrLn $ "Your fortune: " ++ fortunes `at` (read index) 
          tellFortune fortunes
  else putStr "Goodbye."

at :: [a] -> Int -> a
--at lst index = lst !! (index `mod` (length lst))
at lst index = (cycle lst) !! index
    
