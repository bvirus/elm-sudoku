module Sudoku exposing (..)
import Check exposing (check)
import Board exposing (Board)

solve_ : Int -> Int -> Board -> (Board, Bool)
solve_ index attempt board =
    if index < (Board.length board) then
        if attempt >= 1 && attempt <= 9 then
            if (Board.get index board) == Just 0 then
                let
                    nextBoard = Board.set index attempt board
                in
                    if check index nextBoard then
                        let
                            (b, done) = solve_ (index + 1) 1 nextBoard
                        in
                            if done then (b, done)
                            else solve_ index (attempt + 1) board
                    else
                        solve_ index (attempt + 1) board
            else solve_ (index + 1) 1 board
        else (board, False)
    else (board, True)

solve : Board -> (Board, Bool)
solve board = (solve_ 0 1 board)