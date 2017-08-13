module Board exposing (Board, get, set, getRow, getCol, getBox)
import Array exposing (Array)
import Dict


type alias Board = (Array (Array Int))

get : Int -> Int -> Board -> Maybe Int
get row col board =
    case Array.get row board of
        Nothing -> Nothing
        Just r -> Array.get col r

set : Int -> Int -> Int -> Board -> Board
set row col value board =
    case Array.get row board of
        Nothing -> board
        Just r -> Array.set row (Array.set col value r) board

getRow : Int -> Board -> Array Int
getRow row board =
    Maybe.withDefault Array.empty (Array.get row board)

getCol : Int -> Board -> Array Int
getCol col =
    Array.map (\row -> Array.get col row) >> Array.foldl 
        (\item prev -> case item of
                        Nothing -> prev
                        Just v -> Array.push v prev) Array.empty

getBox : Int -> Int -> Board -> Array Int
getBox row col board =
    let 
        tempBox = 
            List.range 0 2
            |> List.map (\i -> ((row - (row % 3)) + i, i))
            |> List.map (\(row, i) -> (row, (col - (col % 3)) + i))
            |> List.map (\(row, col) -> get row col board)
    in
        if List.any (\x -> case x of
                            Nothing -> True
                            Just _ -> False) tempBox
        then Array.empty
        else Array.fromList (List.filterMap identity tempBox)


create: Board
create =
    Array.repeat 9 (Array.repeat 9 0)