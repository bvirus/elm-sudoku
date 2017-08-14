module Board exposing (Board, parseString, create, set, get, getRow, getCol, getBox, length, toList)
import Array exposing (Array)

indexedFilter : (Int -> a -> Bool) -> Array a -> Array a
indexedFilter pred =
    Array.indexedMap (\index v -> (index, v)) >>
    Array.filter (\(index, v) -> pred index v) >>
    Array.map (\(index, v) -> v)

type alias Board = Array Int

length = Array.length
toList = Array.toList

toCol col = col % 9
toRow row = row - (row % 9)

boxStart : Int -> Int
boxStart index = 
    let
        col = (toCol index)
    in
        (27 * (index // 27)) + (col - (col % 3))

inBoxColumn : Int -> Int -> Bool
inBoxColumn start index = 
    (toCol start) == (toCol index)

inBoxRow : Int -> Int -> Bool
inBoxRow start index = 
    (start // 27) == (index // 27)

inBox : Int -> Int -> Bool
inBox start index = 
    let
        colDiff = (toCol index) - (toCol start)
    in
        colDiff >= 0 && colDiff <= 2 && (inBoxRow start index)

set : Int -> Int -> Board -> Board
set =
    Array.set

get : Int -> Board -> Maybe Int
get =
    Array.get

getRow : Int -> Board -> Array Int
getRow index =
    Array.slice (toRow index) ((toRow index) + 8)

getCol : Int -> Board -> Array Int
getCol index =
    indexedFilter (\i item -> (toCol i) == (toCol index))

getBox : Int -> Board -> Array Int
getBox index =
    let 
        start = boxStart index
    in
        indexedFilter (\i item -> inBox start i)

create: Board
create =
    Array.repeat (9 * 9) 0

parseString string =
    let
        parts = String.words string |> List.indexedMap (\index v -> (index, v))
    in
        List.foldl 
            (\(index, v) prev ->
                case String.toInt v of
                  Err e -> set index 0 prev
                  Ok num -> set index num prev)
            create
            parts
