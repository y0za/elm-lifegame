module CoreTests exposing (aliveTests)

import Test exposing (..)
import Expect
import Core exposing (..)


aliveTests : Test
aliveTests =
  describe "Core.alive"
    [ test "alive1" (\_ -> alive True 2 |> Expect.equal True)
    , test "alive2" (\_ -> alive True 3 |> Expect.equal True)
    , test "alive3" (\_ -> alive False 3 |> Expect.equal True)
    , test "dead1" (\_ -> alive True 1 |> Expect.equal False)
    , test "dead2" (\_ -> alive True 4 |> Expect.equal False)
    , test "dead3" (\_ -> alive False 2 |> Expect.equal False)
    , test "dead4" (\_ -> alive False 4 |> Expect.equal False)
    ]
