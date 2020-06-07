module Main exposing (Model, Msg(..), main, update, view)

import Browser
import Card
import Html exposing (Html, div)
import Html.Attributes
import Html.Events.Extra.Pointer as Pointer


type Model
    = CardsOnBoard
        { cards : List Card.Card
        }
    | OneInHand
        { inHand : Card.Card
        , cards : List Card.Card
        }


initModel : Model
initModel =
    CardsOnBoard
        { cards =
            [ { position = { x = 0, y = 0 }
              , state = Card.Free
              , content = "card 2"
              }
            , { position = { x = 0, y = 50 }
              , state = Card.Free
              , content = "card 3"
              }
            , { position = { x = 0, y = 0 }
              , state = Card.Free
              , content = "Hello x"
              }
            ]
        }


type Msg
    = PointerDownMsg Card.Card ( Float, Float )
    | PointerUpMsg
    | PointerMoveMsg ( Float, Float )


update : Msg -> Model -> Model
update msg model =
    case ( msg, model ) of
        ( PointerDownMsg card ( x, y ), OneInHand { cards, inHand } ) ->
            let
                allCards =
                    inHand :: cards

                isNotPickedCard c =
                    c /= card

                removePickedCard cs =
                    List.filter isNotPickedCard cs
            in
            OneInHand
                { cards = removePickedCard allCards
                , inHand =
                    Card.pickupCard x y card
                }

        ( PointerUpMsg, OneInHand { cards, inHand } ) ->
            OneInHand
                { cards = cards
                , inHand =
                    Card.dropCard inHand
                }

        ( PointerMoveMsg ( newX, newY ), OneInHand { cards, inHand } ) ->
            OneInHand
                { cards = cards
                , inHand =
                    Card.moveCard newX newY inHand
                }

        ( PointerDownMsg card ( x, y ), CardsOnBoard { cards } ) ->
            let
                isNotPickedCard c =
                    c /= card

                removePickedCard cs =
                    List.filter isNotPickedCard cs
            in
            OneInHand
                { cards = removePickedCard cards
                , inHand =
                    Card.pickupCard x y card
                }

        _ ->
            model


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
                        "5px 5px 5px rgba(0, 0, 0, 0.5)"
                    , Html.Attributes.style
                        "transition"
                        "box-shadow 0.25s, transform 0.25s"
                    , Html.Attributes.style
                        "z-index"
                        "100"
                    , Html.Attributes.style
                        "transform"
                        "translate(0,-5px)"
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
         , Pointer.onDown (\event -> PointerDownMsg card event.pointer.offsetPos)
         ]
            ++ foo
        )
        [ Html.text card.content
        ]


view : Model -> Html Msg
view model =
    let
        cardsToShow =
            case model of
                CardsOnBoard { cards } ->
                    cards

                OneInHand { cards, inHand } ->
                    cards ++ [ inHand ]
    in
    div
        [ Html.Attributes.style "width" "100vw"
        , Html.Attributes.style "height" "100vh"
        , Pointer.onMove (\event -> PointerMoveMsg event.pointer.pagePos)
        , Pointer.onUp (always PointerUpMsg)
        ]
        (List.map viewCard cardsToShow)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initModel
        , view = view
        , update = update
        }
