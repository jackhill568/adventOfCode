import Data.List.Split

filterIntList :: [Int] -> [Int]
filterIntList [] = []
filterIntList [_] = []
filterIntList (x:y:xs) = (y - x) : filterIntList (y:xs)

listBoolLength :: [Bool] -> Int
listBoolLength = length . filter id


checkSafe :: [Int] -> Bool
checkSafe xs
    | all(\y -> (y >= 1 && y <= 3)) xs && all(>0) xs = True
    | all(\y -> (y>=(-3) && y<=(-1))) xs && all(<0) xs = True
    | otherwise =False

main :: IO ()
main = do
    -- reads data from file
    contents <- readFile "input.txt"

    -- convert file to list of Ints
    let listOfNums =[[read y :: Int | y<-splitOn " " x] | x<-splitOn "\n" contents, x /= ""]

    -- calculetes difference between each of the numbers then checks if theyre in range 
    let listOfSafe = [checkSafe (filterIntList  x) | x <- listOfNums]

    -- get the lenght of the list of safe values
    let numOfSafe = listBoolLength listOfSafe
    print numOfSafe 
