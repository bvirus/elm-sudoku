module Check exposing (check)
import Array exposing (Array)
import Set exposing (Set)
import Board exposing (Board)

without : a -> Array a -> Array a
without v =
    Array.filter (\x -> x /= v)

areDuplicates : List comparable -> Bool
areDuplicates list =
    (Set.size (Set.fromList list)) == (List.length list)
    
checkList : Array Int -> Bool
checkList =
    without 0 >> Array.toList >> areDuplicates

checkRow : Int -> Board -> Bool
checkRow index board =
    checkList (Board.getRow index board)
    
checkCol : Int -> Board -> Bool
checkCol index board =
    checkList (Board.getCol index board)


checkBox : Int -> Board -> Bool
checkBox index board =
    checkList (Board.getBox index board)

check : Int -> Board -> Bool
check index board = 
    (checkRow index board)
    && (checkCol index board)  
    && (checkBox index board)