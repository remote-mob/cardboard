module Main exposing (Model, Msg(..), main, update, view)

import Browser
import Card
import Html exposing (Html, div)
import Html.Attributes
import Html.Events.Extra.Pointer as Pointer


type alias Model =
    { card : Card.Card

    --cards : List Card.Card
    }


initModel : Model
initModel =
    { card =
        { position = { x = 0, y = 0 }
        , state = Card.Free
        , content = "Hello x"
        , cardOffset = Nothing
        }
    }



--{ cards =
--    [ { position = { x = 0, y = 0 }
--      , state = Card.Free
--      , content = "Hello x"
--      , cardOffset = Nothing
--      }
--    ]
--}


type Msg
    = PointerDownMsg ( Float, Float )
    | PointerUpMsg
    | PointerMoveMsg ( Float, Float )


update : Msg -> Model -> Model
update msg model =
    { card =
        case msg of
            PointerDownMsg ( x, y ) ->
                Card.pickupCard x y model.card

            PointerUpMsg ->
                Card.dropCard model.card

            PointerMoveMsg ( newX, newY ) ->
                Card.moveCard newX newY model.card
    }


viewCard : Card.Card -> Html Msg
viewCard card =
    let
        foo =
            case card.state of
                Card.Free ->
                    []

                Card.InHand _ ->
                    [ Html.Attributes.style
                        "box-shadow"
                        "10px 5px 5px red"
                    ]
    in
    div
        ([ Html.Attributes.style "position"
            "absolute"
         , Html.Attributes.style
            "top"
            (String.fromFloat card.position.y ++ "px")
         , Html.Attributes.style
            "left"
            (String.fromFloat card.position.x ++ "px")
         , Html.Attributes.style
            "background-color"
            "lightgrey"
         , Html.Attributes.style
            "padding"
            "1ex"
         , Html.Attributes.style
            "border"
            "1px solid black"
         , Html.Attributes.style
            "border-radius"
            "5px"
         , Pointer.onDown (\event -> PointerDownMsg event.pointer.offsetPos)
         ]
            ++ foo
        )
        [ Html.text card.content
        ]


view : Model -> Html Msg
view model =
    let
        cards =
            [ model.card
            , { position = { x = 0, y = 0 }
              , state = Card.Free
              , content = "card 2"
              , cardOffset = Nothing
              }
            , { position = { x = 0, y = 50 }
              , state = Card.Free
              , content = "card 3"
              , cardOffset = Nothing
              }
            ]
    in
    div
        [ Html.Attributes.style "width" "100vw"
        , Html.Attributes.style "height" "100vh"
        , Pointer.onMove (\event -> PointerMoveMsg event.pointer.pagePos)
        , Pointer.onUp (always PointerUpMsg)
        ]
        (List.map viewCard cards)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initModel
        , view = view
        , update = update
        }
