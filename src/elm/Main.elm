module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Time exposing (Time, millisecond)
import List
import Dict
import Maybe
import Core


-- APP
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL
type alias Model =
  { board : Core.Board
  , running : Bool
  }

init : (Model, Cmd Msg)
init =
  (Model (Core.initBoard 8 8 False) False, Cmd.none)


-- UPDATE
type Msg
  = Start
  | Stop
  | Reset
  | Update Time
  | ToggleCell Core.Position

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Start ->
      ({ model | running = True }, Cmd.none)
    Stop ->
      ({ model | running = False }, Cmd.none)
    Reset ->
      ({ model | board = Core.initBoard 8 8 False, running = False }, Cmd.none)
    Update _ ->
      ({ model | board = Core.nextBoard model.board }, Cmd.none)
    ToggleCell position ->
      ({ model | board = Core.toggleCell model.board position }, Cmd.none)



-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  case model.running of
    True ->
      Time.every (500 * millisecond) Update
    False ->
      Sub.none



-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib
view : Model -> Html Msg
view model =
  div [ class "container", style [("margin-top", "30px"), ("text-align", "center")] ]
    [ boardView model.board
    , button [ onClick Start ] [ text "Start" ]
    , button [ onClick Stop ] [ text "Stop" ]
    , button [ onClick Reset ] [ text "Reset" ]
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
