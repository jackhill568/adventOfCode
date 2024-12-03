module Main where
import Text.Regex.TDFA
import Text.Regex.TDFA.Text ()
import Data.List.Split

-- Multiplication function
mul :: [Int] -> Int
mul (x:y:xs) = x * y

removeBetween :: [String] -> [String]
removeBetween [] = []
removeBetween (x:xs)
  | x == "don't()" = removeBetween rest
  | x == "do()" = removeBetween xs
  | otherwise = x: removeBetween xs
  where rest = dropUntil xs

dropUntil :: [String] -> [String]
dropUntil [] = []
dropUntil (x:xs)
  | x=="do()" = xs
  | otherwise = dropUntil xs

main :: IO ()
main = do
  -- Read contents from input.txt
  contents <- readFile "input.txt"
  
  let pattern = "mul\\(([0-9][0-9]?[0-9]?),([0-9][0-9]?[0-9]?)\\)|do\\(\\)|don't\\(\\)"

  let matches = getAllTextMatches (contents =~ pattern) :: [String]

  let filtered = removeBetween matches
  let nums = map (\z -> splitOn "," z)  [filter (\z -> not(elem z "mul()")) x | x <- filtered]

  let products = [[read y :: Int | y <- x] | x <- nums]

  let sumpy = sum [mul x | x<-products]
  print sumpy

