module Main where
import Text.Regex.TDFA
import Text.Regex.TDFA.Text ()
import Data.List.Split

-- Multiplication function
mul :: [Int] -> Int
mul (x:y:xs) = x * y


main :: IO ()
main = do
  -- Read contents from input.txt
  contents <- readFile "input.txt"
  
  let pattern = "mul\\(([0-9][0-9]?[0-9]?),([0-9][0-9]?[0-9]?)\\)"

  let matches = getAllTextMatches (contents =~ pattern) :: [String]
  let nums = map (\z -> splitOn "," z)  [filter (\z -> not(elem z "mul()")) x | x <- matches]

  let products = [[read y :: Int | y <- x] | x <- nums]

  let sumpy = sum [mul x | x<-products]
  print sumpy

