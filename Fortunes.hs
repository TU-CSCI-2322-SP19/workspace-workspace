import System.Environment
import System.IO
import System.Console.GetOpt

-- Problem 1 will be done as a class.
-- --   1) Figure out how to implement the "Count" flag.
-- -- 
-- -- Core Exercise: Problems 2-4
-- --   2) Stop asking for a number each time: just give them the next fortune in the list.
-- --   3) Implement the 'Start' flag. If provided, don't ask for a number.
-- --   3) Make an action getBool :: IO Bool to get a Yes/No response. 
-- --     Accept yes/y no/n in any captilization. If they input anything else, ask again.
--
-- -- Extra Fun Problems: Feature creep! Ask the user what they want. Support the following
-- requests: 
-- -- Hint: Make an "Request" data-type and a parseRequest:: String -> Request function. 
-- --   5) "Give me a fortune" (or any string with fortune in it)
-- --       Ask for a number, and print out the corresponding fortune
-- --   6) "Remember _______" Treat the blank as a 'to-do', and print out a reminder on every prompt
-- --   7) "Remind me" Only print out the reminder when requested.
-- --   8) Make parseRequest more robust: return a Maybe Request. 
-- --   9) "What is _____":  Evaluates a prefix mathematical expression and print the result.
-- --      You'll need to import Calc
--
--

data Flag = Help | Start String | Count String deriving (Eq, Show)

options :: [OptDescr Flag]
options = [ Option ['h'] ["help", "why"] (NoArg Help) "Print a help message and exit."
          , Option ['s'] ["start"] (ReqArg Start "<num>") "Print the <num> fortune and exit."
          , Option ['k'] ["kount"] (ReqArg Count "<num>") "Print <num> fortunes each time."
          ]

main :: IO ()
main = do args <- getArgs
          let (flags, others, errors) = getOpt Permute options args
          if Help `elem` flags || (not $ null errors)
          then putStrLn $ usageInfo "Fortunes [OPTIONS...] [file]" options
          else let fileName = if null others then "fortunes.txt" else head others
               in do fortuneText <- readFile fileName
                     let fortunes = lines fortuneText
                     name <- prompt "What is your name? "
                     putStr $ "Welcome " ++ name ++ ". "
                     tellFortune fortunes

prompt :: String -> IO String
prompt str = do
  putStr str
  hFlush stdout
  anwer <- getLine
  return anwer

getBool :: IO Bool
getBool = undefined

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
    
