module TestSemiGroup exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import SemiGroup
import Test exposing (..)


suite : Test.Test
suite =
    Test.describe "The SemiGroup module"
        [ Test.fuzz3 Fuzz.string Fuzz.string Fuzz.string "tests that ++ equivalent to SemiGroup.append for string" <|
            \stringOne stringTwo stringThree ->
                let
                    leftSide =
                        SemiGroup.append SemiGroup.string (SemiGroup.append SemiGroup.string stringOne stringTwo) stringThree

                    rightSide =
                        SemiGroup.append SemiGroup.string stringOne (SemiGroup.append SemiGroup.string stringTwo stringThree)
                in
                Expect.equal leftSide rightSide
        , Test.fuzz3 Fuzz.int Fuzz.int Fuzz.int "tests that addition equivalent to SemiGroup.append for Sum" <|
            \one two three ->
                let
                    leftSide =
                        SemiGroup.append SemiGroup.sum (SemiGroup.append SemiGroup.sum (SemiGroup.Sum one) (SemiGroup.Sum two)) (SemiGroup.Sum three)

                    rightSide =
                        SemiGroup.append SemiGroup.sum (SemiGroup.Sum one) (SemiGroup.append SemiGroup.sum (SemiGroup.Sum two) (SemiGroup.Sum three))
                in
                Expect.equal leftSide rightSide
        , Test.fuzz3 Fuzz.int Fuzz.int Fuzz.int "tests that multiplication equivalent to SemiGroup.append for Product" <|
            \one two three ->
                let
                    leftSide =
                        SemiGroup.append SemiGroup.product (SemiGroup.append SemiGroup.product (SemiGroup.Product one) (SemiGroup.Product two)) (SemiGroup.Product three)

                    rightSide =
                        SemiGroup.append SemiGroup.product (SemiGroup.Product one) (SemiGroup.append SemiGroup.product (SemiGroup.Product two) (SemiGroup.Product three))
                in
                Expect.equal leftSide rightSide

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
