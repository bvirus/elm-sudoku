module Board exposing (Board, parseString, create, set, get, getRow, getCol, getBox, length, toList)
import Array exposing (Array)

type alias Board = Array Int

length : Array a -> Int
length = Array.length

toList : Array a -> List a
toList = Array.toList

toCol : Int -> Int
toCol col = col % 9

toRow : Int -> Int
toRow row = row - (row % 9)

boxStart : Int -> Int
boxStart index = 
    let
        col = (toCol index)
    in
        (27 * (index // 27)) + (col - (col % 3))

set : Int -> Int -> Board -> Board
set =
    Array.set

get : Int -> Board -> Maybe Int
get =
    Array.get

getRow : Int -> Board -> Array (Maybe Int)
getRow index =
    Array.slice (toRow index) ((toRow index) + 8)
    >> Array.map (\x -> Just x)

getCol : Int -> Board -> Array (Maybe Int)
getCol index board =
    Array.fromList (List.range 0 8)
    |> Array.map (\x -> (9*x) + (toCol index))
    |> Array.map (\x -> Array.get x board)

getBox : Int -> Board -> Array (Maybe Int)
getBox index board =
    let 
        start = boxStart index
    in
        List.range 0 2
        |> List.concatMap (\x -> 
            List.range 0 2
            |> List.map (\y -> (x, y)))
        |> List.map (\(x, y) -> start + (9 * x) + y)
        |> List.map (\i -> Array.get i board)
        |> Array.fromList

create: Board
create =
    Array.repeat (9 * 9) 0

parseString : String -> Board
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
