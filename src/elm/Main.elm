module Main exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List


-- APP
main : Program Never Model Msg
main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL
type alias Model =
  { board : List (List Bool)
  }

model : Model
model =
  { board = List.repeat 8 <| List.repeat 8 False
  }


-- UPDATE
type Msg = ToggleCell Int Int

update : Msg -> Model -> Model
update msg model =
  case msg of
    ToggleCell y x ->
      { model | board =
        model.board
          |> List.indexedMap
            (\index row ->
              if index == y then
                toggleCellInRow row x
              else
                row
            )
      }

toggleCellInRow : List Bool -> Int -> List Bool
toggleCellInRow row target =
  let
    toggle index state =
      if index == target then
        not state
      else
        state
  in
    List.indexedMap toggle row


-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib
view : Model -> Html Msg
view model =
  div [ class "container", style [("margin-top", "30px"), ( "text-align", "center" )] ][    -- inline CSS (literal)
    boardView model.board
  ]

boardView : List (List Bool) -> Html Msg
boardView board =
  Html.table [ class "board" ] <|
    List.indexedMap
      (\y row ->
        tr [] (
          row |> List.indexedMap
            (\x state -> td [ class <| stateClass state, onClick <| ToggleCell y x ] [])
        )
      )
      board

stateClass : Bool -> String
stateClass state =
  if state then
    "alive"
  else
    "dead"


-- CSS STYLES
styles : { img : List ( String, String ) }
styles =
  {
    img =
      [ ( "width", "33%" )
      , ( "border", "4px solid #337AB7")
      ]
  }
