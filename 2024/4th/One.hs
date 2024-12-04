import Data.List.Split

horRecSearch :: [Char] -> Int
horRecSearch (_:_:_:[]) = 0
horRecSearch (x:m:a:s:xs)
    | [x,m,a,s] == "XMAS" = 1+horRecSearch (m:a:s:xs)
    | [x,m,a,s] == "SAMX" = 1+horRecSearch (m:a:s:xs)
    | otherwise = horRecSearch (m:a:s:xs)
horRecSearch _ = 0

verRecCycle :: [String] -> [Int]
verRecCycle (_:_:_:[]) = []
verRecCycle (a:b:c:d:xs) = verRecSearch a b c d ++ verRecCycle (b:c:d:xs)
verRecCycle _ = []

checkLine :: Int -> [Int] -> [Int] -> [Int] -> Int
checkLine xval midx aidx sidx
    | back && forw && stra = 3
    | back && forw || back && stra || forw && stra = 2
    | back && forw && stra = 3
    | not(back || forw || stra) = 0
    | otherwise = 1
    where
        back = (elem (xval-1) midx && elem (xval-2) aidx && elem (xval-3) sidx)
        forw = (elem (xval+1) midx && elem (xval+2) aidx && elem (xval+3) sidx)
        stra = (elem xval midx && elem xval aidx && elem xval sidx)

verRecSearch :: String -> String -> String -> String -> [Int]
verRecSearch a b c d = 
    [checkLine xval midx aidx sidx | xval <- xidx] ++
    [checkLine xval mridx aridx sridx | xval <- xridx]
    
    where
        xidx = findIndices 'X' a 
        xridx = findIndices 'X' d
        midx = findIndices 'M' b 
        mridx = findIndices 'M' c
        aidx = findIndices 'A' c
        aridx = findIndices 'A' b
        sidx = findIndices 'S' d 
        sridx = findIndices 'S' a


getIndices :: String -> [(Int, Char)]
getIndices = zip [0..]

findIndices :: Char -> String -> [Int]
findIndices x = map fst . filter ((== x) . snd) . getIndices

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let listOfLines = splitOn "\n" contents
    
    let numOfHor = sum [horRecSearch x| x<-listOfLines]
    
    let numOfVer = verRecCycle listOfLines
    
    let totalCount = sum numOfVer + numOfHor
    print numOfHor
    print totalCount
    



