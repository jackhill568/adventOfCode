import Data.List.Split (splitOn)

findGuard :: [[Char]] -> Maybe (Int, Int)
findGuard xs 
    | null pos = Nothing
    | otherwise = Just (head pos)
    where
        pos = [(j, i) | (i, row) <- zip [0..] xs, (j, c) <- zip [0..] row, elem c "v><^"]
            

addPadding :: [[Char]] -> [[Char]]
addPadding lineList = 
    topABot ++ [('0': x ++ "0") | x<- lineList] ++ topABot
    where
        topABot = [replicate (length (head lineList)+2) '0']

getThingOnGrid :: (Int, Int) -> [[Char]] -> Char
getThingOnGrid (x, y) xs = ((xs !! y) !! x)

changeThingOnGrid :: (Int, Int) -> Char -> [[Char]] -> [[Char]]
changeThingOnGrid (j, i) sym xs = 
    take i xs ++ [take j (xs !! i) ++ [sym] ++ drop (j + 1) (xs !! i)] ++ drop (i + 1) xs

getNextSym :: (Int, Int) -> Char -> [[Char]] -> Char
getNextSym (x, y) sym xs
    | sym == '^' = getThingOnGrid (x, y-1) xs
    | sym == '>' = getThingOnGrid (x+1, y) xs
    | sym == 'v' = getThingOnGrid (x, y+1) xs
    | otherwise = getThingOnGrid (x-1,y) xs

move :: (Int, Int) -> Char -> (Int, Int)
move (x, y) sym
    | sym == '^' = (x, y-1)
    | sym == '>' = (x+1, y)
    | sym == 'v' = (x, y+1)
    | otherwise = (x-1, y)

rotateSym :: Char -> Char
rotateSym '^' = '>'
rotateSym '>' = 'v'
rotateSym 'v' = '<'
rotateSym '<' = '^'
rotateSym _ = '^'

countSteps :: [[Char]] -> (Int, Int) -> Int
countSteps lineList (x, y)
    | nextSquare == '#' = countSteps (changeThingOnGrid (x, y) nextSym lineList) (x, y)
    | nextSquare == '.' = 1 + countSteps (changeThingOnGrid nextPos sym removedGuard) nextPos
    | nextSquare == 'X' = countSteps (changeThingOnGrid nextPos sym removedGuard) nextPos
    | otherwise = 0
    where
        sym = getThingOnGrid (x, y) lineList
        nextSquare = getNextSym (x, y) sym lineList
        nextPos = move (x, y) sym
        removedGuard = changeThingOnGrid (x,y) 'X' lineList
        nextSym = rotateSym sym

main :: IO()
main = do
  contents <- readFile "input.txt"
  let listOfLines = splitOn "\n" contents
  let paddedLines = addPadding [x | x<-listOfLines, x/= ""]
  let guardPos = findGuard paddedLines
  
  case guardPos of
    Just (x, y) -> print $ countSteps paddedLines (x, y)
    Nothing -> putStrLn "guard Not Found Oop"
