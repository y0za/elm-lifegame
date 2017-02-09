module CoreTests exposing (ruleTests)

import Test exposing (..)
import Expect
import Core exposing (..)


ruleTests : Test
ruleTests =
  describe "Core.rule"
    [ test "alive1" (\_ -> rule True 2 |> Expect.equal True)
    , test "alive2" (\_ -> rule True 3 |> Expect.equal True)
    , test "alive3" (\_ -> rule False 3 |> Expect.equal True)
    , test "dead1" (\_ -> rule True 1 |> Expect.equal False)
    , test "dead2" (\_ -> rule True 4 |> Expect.equal False)
    , test "dead3" (\_ -> rule False 2 |> Expect.equal False)
    , test "dead4" (\_ -> rule False 4 |> Expect.equal False)
    ]
