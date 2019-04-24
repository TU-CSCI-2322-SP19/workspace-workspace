import System.Environment
import System.IO
import System.Console.GetOpt

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
    
