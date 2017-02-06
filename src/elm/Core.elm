module Core exposing (..)


alive : Bool -> Int -> Bool
alive before around =
  case before of
    True -> around == 2 || around == 3
    False -> around == 3
