module Card exposing (..)


type CardState
    = Free
    | InHand Position


type alias Position =
    { x : Float
    , y : Float
    }
