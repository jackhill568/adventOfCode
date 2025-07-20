import Data.List.Split
import Data.List (permutations)


main :: IO()
main = do
    contents <- readFile "input.txt"
    let listLines = splitOn "\n" contents
    
