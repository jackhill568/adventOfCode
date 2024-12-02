import Data.List.Split

isSortedAsc :: (Ord a, Num a)=>[a] -> Bool
isSortedAsc [] = True
isSortedAsc [x] = True
isSortedAsc (x:y:xs) = x<=y && (y-x)<=3 && (y-x)>=1 &&  isSortedAsc (y:xs)

isSortedDesc :: (Ord a, Num a) => [a] -> Bool
isSortedDesc [] = True
isSortedDesc [x] = True
isSortedDesc (x:y:xs) = x>=y && (x-y) <= 3 && (x-y)>=1 && isSortedDesc (y:xs)

removeOneElement :: Ord a => [a] -> [[a]]
removeOneElement [] = []
removeOneElement [x] = []
removeOneElement (x:xs) = xs : [x : y | y <- removeOneElement xs] ++ [init (x:xs)]

makeSorted :: (Ord a, Num a) => [a] -> Bool
makeSorted list
  | isSortedAsc list = True
  | isSortedDesc list = True
  | otherwise = findSorted (removeOneElement list)

findSorted :: (Ord a, Num a) => [[a]] -> Bool
findSorted [] = False
findSorted (x:xs)
  | isSortedAsc x = True
  | isSortedDesc x = True
  | otherwise = findSorted xs

main :: IO ()
main = do
    -- reads data from file
    contents <- readFile "input.txt"

    -- convert file to list of Ints
    let listOfNums =[[read y :: Int | y<-splitOn " " x] | x<-splitOn "\n" contents, x /= ""]

    let diffs = [makeSorted x | x <- listOfNums]
    let safeAnswer = [True | x <- diffs, x /= False]
    let num = length safeAnswer
    print num
