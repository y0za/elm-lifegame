module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List
import Dict
import Maybe
import Core


-- APP
main : Program Never Model Msg
main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL
type alias Model =
  { board : Core.Board
  }

model : Model
model =
  { board = Core.initBoard 8 8 False
  }


-- UPDATE
type Msg = ToggleCell Core.Position

update : Msg -> Model -> Model
update msg model =
  case msg of
    ToggleCell position ->
      { model | board = Core.toggleCell model.board position }


-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib
view : Model -> Html Msg
view model =
  div [ class "container", style [("margin-top", "30px"), ( "text-align", "center" )] ][    -- inline CSS (literal)
    boardView model.board
  ]

boardView : Core.Board -> Html Msg
boardView board =
  Core.range (Core.height board)
    |> List.map
      (\y ->
        tr []
          (Core.range (Core.width board) |> List.map
            (\x -> td [ class <| stateClass <| Dict.get (y, x) board
                      , onClick <| ToggleCell (y, x)
                      ] [])
          )
      )
    |> Html.table [ class "board" ]

stateClass : Maybe Core.State -> String
stateClass state =
  case state of
    Just True  -> "alive"
    Just False -> "dead"
    _          -> "empty"


-- CSS STYLES
styles : { img : List ( String, String ) }
styles =
  {
    img =
      [ ( "width", "33%" )
      , ( "border", "4px solid #337AB7")
      ]
  }
