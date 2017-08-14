module Main exposing (..)
import Board exposing (Board)
import Sudoku exposing (solve)
import Html exposing (Html, button, div, text, label, input, br)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (type_, value, class, name, id)
import Array


main =
  Html.beginnerProgram { model = model, view = view, update = update }


type alias Model = Board

model : Model
model = Board.create

type Msg = Change Int String | Reset | Solve

update : Msg -> Model -> Model
update msg model = 
    case msg of
        Reset -> Board.create
        Solve -> Tuple.first (Sudoku.solve model)
        Change index value -> 
            case String.toInt value of 
                Err e -> Board.set index 0 model
                Ok v -> Board.set index v model

toRowsOf : Int -> List a -> List (List a)
toRowsOf r =
    List.foldr 
        (\x (work, all) -> 
            if (List.length work) < r then
                (List.append [x] work, all)
            else
                ([x], List.append [work] all)) 
        ([], [])
   >> (\(left, right) -> List.append [left] right)

view : Model -> Html Msg
view model =
    div []
        [
            button [ onClick Solve ] [ text "Solve"]
            , button [ onClick Reset ] [ text "Clear" ]
            , br [] []
            , div [class "grid"] 
                (Array.toList model
                |> toRowsOf 9
                |> List.indexedMap 
                    (\ri -> div [ class "grid-row" ] 
                        << List.indexedMap 
                        (\ci  -> viewBox (ci + (ri*9)))
                    ))
        ]

viewBox : Int -> Int -> Html Msg
viewBox index item =
    let
        str = if item == 0 then "" else toString item
    in
        input [ type_ "text"
                -- , onInput (Change index) 
                ]
            []