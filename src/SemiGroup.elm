module SemiGroup exposing
    ( Product(..)
    , SemiGroup(..)
    , Sum(..)
    , append
    , array
    , list
    , product
    , string
    , sum
    )

import Array
import Dict
import Platform.Cmd
import Platform.Sub
import Set


type SemiGroup a
    = SemiGroup (a -> a -> a)


{-| Take the way to append a semigroups.
-}
append : SemiGroup a -> (a -> a -> a)
append (SemiGroup mappend) =
    mappend


{-| `Semigroup` type for `String`.
-}
string : SemiGroup String
string =
    SemiGroup (++)


{-| `Semigroup` under addition
-}
type Sum a
    = Sum a


{-| `Semigroup` type for `Sum`.
-}
sum : SemiGroup (Sum number)
sum =
    SemiGroup (\(Sum a) (Sum b) -> Sum <| a + b)


{-| `MoSemigroupnoid` under multiplication.
-}
type Product a
    = Product a


{-| `Semigroup` type for `Product`.
-}
product : SemiGroup (Product number)
product =
    SemiGroup (\(Product a) (Product b) -> Product <| a * b)


{-| `Semigroup` type for `List`.
-}
list : SemiGroup (List a)
list =
    SemiGroup (++)


{-| `SemiGroup` type for `Array`.
-}
array : SemiGroup (Array.Array a)
array =
    SemiGroup Array.append


{-| `SemiGroup` type for `Dict`.
-}
dict : SemiGroup (Dict.Dict comparable a)
dict =
    SemiGroup Dict.union


{-| `SemiGroup` type for `Set`.
-}
set : SemiGroup (Set.Set comparable)
set =
    SemiGroup Set.union


{-| `SemiGroup` type for `Cmd`.
-}
cmd : SemiGroup (Cmd comparable)
cmd =
    SemiGroup (\a b -> Cmd.batch [ a, b ])


{-| `Monoid` type for `Sub`.
-}
sub : SemiGroup (Sub comparable)
sub =
    SemiGroup (\a b -> Sub.batch [ a, b ])
