module Tests exposing (..)

import Test
import CoreTests


all : Test
all =
  CoreTests.aliveTests
