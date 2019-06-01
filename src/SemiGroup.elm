module SemiGroup exposing (SemiGroup(..))


type SemiGroup a
    = SemiGroup (a -> a -> a)
