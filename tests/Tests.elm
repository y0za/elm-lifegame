module Tests exposing (..)

import Test exposing (..)
import CoreTests


all : Test
all =
  CoreTests.ruleTests
