import Data.List.Split
import Data.Ord (comparing)
import Data.List (sort, elemIndex, sortBy)

getRuleApplies :: [[Int]] -> [Int] -> [[Int]]
getRuleApplies x y = [e | e <- x, elem (head e) y && elem (last e) y]

applyRules :: [Int] -> [[Int]] -> [Int]
applyRules indata rules = reverse $ sortBy (comparing (\z -> length (filter (\y -> head y == z) rules))) indata

getMid :: [Int] -> Int
getMid xs = xs !! div (length xs) 2

main :: IO()

main = do
    contents <- readFile "input.txt"
    let bigList = splitWhen (=="") $ lines contents
    
    let rules = sort [[read y :: Int | y<- splitOn "|" x] | x<-head bigList]
    let indata = [[read y :: Int | y <- splitOn "," x] | x <- last bigList]
    let updated = [applyRules x $ getRuleApplies rules x | x <- indata]
    let correctSum = sum [getMid x | x<-updated , y<- indata, x==y]
    let inCorrectSum = sum [getMid x | x<-updated]
    print correctSum
    print $ inCorrectSum - correctSum

