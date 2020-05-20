module Main exposing (Model, Msg(..), main, newCard, update, view)

import Browser
import Html exposing (Html, div)
import Html.Attributes
import Html.Events.Extra.Pointer as Pointer


type alias Model =
    Card


type alias Model2 =
    List Card


type alias Card =
    { position :
        { x : Float
        , y : Float
        }
    , state : CardState
    , content : String
    }


type CardState
    = Free
    | InHand


newCard : Card
newCard =
    { position = { x = 0, y = 0 }
    , state = Free
    , content = "Hello x"
    }


type Msg
    = PointerDownMsg ( Float, Float )
    | PointerUpMsg ( Float, Float )
    | PointerMoveMsg ( Float, Float )
    | PointerDownMsgInt ( Int, Int )


pickupCard : Card -> Card
pickupCard card =
    { card
        | state = InHand
    }


dropCard : Card -> Card
dropCard card =
    { card
        | state = Free
    }


moveCard : Float -> Float -> (Card -> Card)
moveCard x y card =
    case card.state of
        InHand ->
            { card | position = { x = x, y = y } }

        Free ->
            card


update : Msg -> Model -> Model
update msg model =
    case msg of
        PointerDownMsg ( newX, newY ) ->
            pickupCard model

        PointerUpMsg ( newX, newY ) ->
            dropCard model

        PointerMoveMsg ( newX, newY ) ->
            moveCard newX newY model

        PointerDownMsgInt _ ->
            model


viewCard : Card -> Html msg
viewCard card =
    div
        [ Html.Attributes.style "position"
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
        ]
        [ Html.text card.content
        ]


view : Model -> Html Msg
view model =
    let
        cards =
            [ model ]
    in
    div
        [ Html.Attributes.style "width" "100vw"
        , Html.Attributes.style "height" "100vh"
        , Pointer.onDown (\event -> PointerDownMsg event.pointer.offsetPos)
        , Pointer.onUp (\event -> PointerUpMsg event.pointer.offsetPos)
        , Pointer.onMove (\event -> PointerMoveMsg event.pointer.pagePos)
        ]
        (List.map viewCard cards)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = newCard
        , view = view
        , update = update
        }
