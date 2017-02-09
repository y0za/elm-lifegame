module Core exposing (..)

type alias Position = (Int Int)
type alias State = Bool

rule : State -> Int -> State
rule state aroundAlives =
  case (state, aroundAlives) of
    (True, 2)  -> True
    (True, 3)  -> True
    (False, 3) -> True
    _          -> False
