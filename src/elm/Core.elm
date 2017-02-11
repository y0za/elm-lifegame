module Core exposing (..)

import Dict
import List
import Maybe

type alias State = Bool
type alias Position = (Int, Int)
type alias PositionOffset = (Int, Int)
type alias Cell = (Position, State)
type alias Board = Dict.Dict Position State

rule : State -> Int -> State
rule state aroundAlives =
  case (state, aroundAlives) of
    (True, 2)  -> True
    (True, 3)  -> True
    (False, 3) -> True
    _          -> False

range : Int -> List Int
range count = List.range 0 (count - 1)

initCell : Position -> State -> Cell
initCell pos state = (pos, state)

initRow : Int -> Int -> State -> List Cell
initRow y count state =
  range count
    |> List.map (\x -> initCell (y, x) state)

initBoard : Int -> Int -> State -> Board
initBoard height width state =
  range height
    |> List.map (\y -> initRow y width state)
    |> List.concat
    |> Dict.fromList

aroundOffsets : List PositionOffset
aroundOffsets =
  [ (-1, -1), (-1, 0), (-1, 1)
  , ( 0, -1),          ( 0, 1)
  , ( 1, -1), ( 1, 0), ( 1, 1)
  ]

aroundPositions : Position -> List Position
aroundPositions (x, y) =
  List.map (\(dx, dy) -> (x + dx, y + dy)) aroundOffsets


aroundAlives : Board -> Position -> Int
aroundAlives board pos =
  aroundPositions pos
    |> List.map (\pos -> Dict.get pos board)
    |> List.map (Maybe.withDefault False)
    |> List.filter identity
    |> List.length

nextState : Board -> Cell -> State
nextState board (pos, state) =
  rule state (aroundAlives board pos)

nextBoard : Board -> Board
nextBoard board =
  Dict.map (nextState board |> curry) board

toggleCell : Board -> Position -> Board
toggleCell board pos =
  Dict.update pos (Maybe.andThen (\state -> Just (not state))) board

height : Board -> Int
height board =
  Dict.foldl (\(y, _) _ i -> max y i) 0 board

width : Board -> Int
width board =
  Dict.foldl (\(_, x) _ j -> max x j) 0 board
