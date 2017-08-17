module Check exposing (check)
import Array exposing (Array)
import Board exposing (Board)
  
checkList : Int -> Array (Maybe Int) -> Bool
checkList attempt =
    not << List.any (\x -> case x of 
        Nothing -> False
        Just v -> v == attempt) << Array.toList

checkRow : Int -> Int -> Board -> Bool
checkRow index attempt board =
    checkList attempt (Board.getRow index board)
    
checkCol : Int -> Int -> Board -> Bool
checkCol index attempt board =
    checkList attempt (Board.getCol index board)


checkBox : Int -> Int -> Board -> Bool
checkBox index attempt board =
    checkList attempt (Board.getBox index board)

check : Int -> Int -> Board -> Bool
check index attempt board = 
    (checkRow index attempt board)
    && (checkCol index attempt board)  
    && (checkBox index attempt board)