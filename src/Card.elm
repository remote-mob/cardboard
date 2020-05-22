module Card exposing (..)


type alias DummyInt =
    Int


type CardState
    = Free
    | InHand Position


type alias Position =
    { x : Float
    , y : Float
    }
