{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies        #-}

module Main where

import           SizedGrid.Coord.HardWrap
import           SizedGrid.Coord.Periodic
import           SizedGrid.Peano
import           SizedGrid.Type.Number

import           Test.Utils

import           Hedgehog
import qualified Hedgehog.Gen             as Gen
import           Test.Tasty

genPeriodic :: (n ~ S x, SPeanoI x) => Gen (Periodic n)
genPeriodic = Periodic <$> Gen.enumBounded

main =
    let periodic =
            let g :: Gen (Periodic (AsPeano 20)) = genPeriodic
            in [semigroupLaws g, monoidLaws g, additiveGroupLaws g]
        hardWrap =
            let g :: Gen (Periodic (AsPeano 20)) = Periodic <$> Gen.enumBounded
            in [semigroupLaws g, monoidLaws g]
    in defaultMain $ testGroup "tests" [testGroup "Periodic 20" periodic, testGroup "HardWrap 20" hardWrap]
