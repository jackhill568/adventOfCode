import Data.List.Split
import System.IO



main :: IO ()

main = do
    contents <- readFile "input.txt"
    
    print splitOn "\n" contents
