module Sudoku exposing (solve)

import Array exposing (Array(..))
import Board exposing (Board, get, set)

withoutDuplicates : List a -> List a
withoutDuplicates =
    List.foldl 
        (\item prev -> 
            if not (List.member item prev) then item :: prev else prev) 
        []

areDuplicates : List a -> Bool
areDuplicates list =
    (==) 
        (List.length (withoutDuplicates list)) 
        (List.length list)

checkRow : Int -> Board -> Bool
checkRow row board =
    case (Board.getRow row board) of
        Just rowList -> areDuplicates rowList
        Nothing -> False
    
checkCol : Int -> Board -> Bool
checkCol col board =
    areDuplicates (Board.getCol col board)

checkBox : Int -> Board -> Bool
checkBox row col board =
    areDuplicates (Board.getBox row col board)
