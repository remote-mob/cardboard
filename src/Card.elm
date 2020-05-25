module Card exposing (..)


type CardState
    = Free
    | InHand Position


type alias Position =
    { x : Float
    , y : Float
    }


type alias Card =
    { position :
        { x : Float
        , y : Float
        }
    , state : CardState
    , content : String
    }


pickupCard : Float -> Float -> Card -> Card
pickupCard x y card =
    { card
        | state = InHand { x = x, y = y }
    }


dropCard : Card -> Card
dropCard card =
    { card
        | state = Free
    }


moveCard : Float -> Float -> (Card -> Card)
moveCard mx my card =
    case card.state of
        InHand offset ->
            let
                newX =
                    mx - offset.x

                newY =
                    my - offset.y
            in
            { card | position = { x = newX, y = newY } }

        Free ->
            card
