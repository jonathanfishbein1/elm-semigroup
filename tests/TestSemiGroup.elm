module TestSemiGroup exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import SemiGroup
import Test exposing (..)


suite : Test.Test
suite =
    Test.describe "The SemiGroup module"
        [ Test.fuzz3 Fuzz.string Fuzz.string Fuzz.string "tests that ++ equivalent to Monoid.append for list" <|
            \stringOne stringTwo stringThree ->
                let
                    leftSide =
                        SemiGroup.append SemiGroup.string (SemiGroup.append SemiGroup.string stringOne stringTwo) stringThree

                    rightSide =
                        SemiGroup.append SemiGroup.string stringOne (SemiGroup.append SemiGroup.string stringTwo stringThree)
                in
                Expect.equal leftSide rightSide

        -- , Test.fuzz (Fuzz.list Fuzz.string) "tests that ++ equivalent to Monoid.concat for string" <|
        --     \randomlyGeneratedStringList ->
        --         let
        --             expected =
        --                 List.foldr String.append "" randomlyGeneratedStringList
        --         in
        --         randomlyGeneratedStringList
        --             |> Monoid.concat Monoid.string
        --             |> Expect.equal expected
        -- , Test.fuzz (Fuzz.list Fuzz.int) "tests List.sum equivalent to Monoid.concat Monoid.sum " <|
        --     \randomlyGeneratedIntList ->
        --         let
        --             expected =
        --                 Monoid.Sum <| List.sum randomlyGeneratedIntList
        --         in
        --         randomlyGeneratedIntList
        --             |> List.map Monoid.Sum
        --             |> Monoid.concat Monoid.sum
        --             |> Expect.equal expected
        -- , Test.fuzz (Fuzz.intRange -10 10) "tests List.product equivalent to Monoid.concat Monoid.product " <|
        --     \randomlyGeneratedInt ->
        --         let
        --             expected =
        --                 Monoid.Product randomlyGeneratedInt
        --         in
        --         randomlyGeneratedInt
        --             |> Monoid.Product
        --             |> Monoid.append Monoid.product (Monoid.Product 1)
        --             |> Expect.equal expected
        ]
