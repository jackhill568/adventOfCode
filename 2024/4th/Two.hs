import Data.List.Split

verRecCycle :: [String] -> [Int]
verRecCycle (_:_:_:[]) = []
verRecCycle (a:b:c:xs) = verRecSearch a b c ++ verRecCycle (b:c:xs)
verRecCycle _ = []

isDuple :: Eq a => a -> [a] -> Bool
isDuple x xs= length (filter (==x) xs) >=2

removeSingles :: [Int] -> [Int]
removeSingles x = filter (\z -> isDuple z x) x


checkMas :: Int -> [Int] -> [Int] -> [Int]
checkMas mval aidx sidx
    | back && forw  = [mval-1, mval+1]
    | back = [mval-1]
    | forw = [mval+1]
    | otherwise = []
    where
        back = (elem (mval-1) aidx && elem (mval-2) sidx)
        forw = (elem (mval+1) aidx && elem (mval+2) sidx)

verRecSearch :: String -> String -> String -> [Int]
verRecSearch a b c = 
    removeSingles (concat ([checkMas mval aidx sidx | mval <- midx] 
        ++[checkMas mval aridx sridx | mval <- mridx]))
    
    where
        midx = findIndices 'M' a 
        mridx = findIndices 'M' c
        aidx = findIndices 'A' b
        aridx = findIndices 'A' b
        sidx = findIndices 'S' c
        sridx = findIndices 'S' a


getIndices :: String -> [(Int, Char)]
getIndices = zip [0..]

findIndices :: Char -> String -> [Int]
findIndices x = map fst . filter ((== x) . snd) . getIndices

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let listOfLines = splitOn "\n" contents
    
    let numOfVer = verRecCycle listOfLines
    let numXs = div (length numOfVer) 2
    print numOfVer
    print numXs



