module Main exposing (Model, Msg(..), initialModel, main, update, view)

import Browser
import Color
import Html exposing (Html, div)
import Html.Attributes
import Html.Events.Extra.Pointer as Pointer
import TypedSvg exposing (circle, rect, svg)
import TypedSvg.Attributes exposing (cx, cy, fill, height, r, stroke, width, x, y)
import TypedSvg.Types as Paint exposing (Paint, px)


type alias Model =
    { cardPos :
        { x : Float
        , y : Float
        }
    , cardState : CardState
    , helloPos :
        { x : Int
        , y : Int
        }
    }


type CardState
    = Free
    | InHand


initialModel : Model
initialModel =
    { cardPos = { x = 0, y = 0 }, cardState = Free, helloPos = { x = 75, y = 75 } }


type Msg
    = PointerDownMsg ( Float, Float )
    | PointerUpMsg ( Float, Float )
    | PointerMoveMsg ( Float, Float )
    | PointerDownMsgInt ( Int, Int )


update : Msg -> Model -> Model
update msg model =
    let
        cardIsMoving =
            model.cardState == InHand
    in
    case msg of
        PointerDownMsg ( newX, newY ) ->
            { model
                | cardPos = { x = newX, y = newY }
                , cardState = InHand
            }

        PointerUpMsg ( newX, newY ) ->
            { model
                | cardState = Free
            }

        PointerMoveMsg ( newX, newY ) ->
            if cardIsMoving then
                { model | cardPos = { x = newX, y = newY } }

            else
                model

        PointerDownMsgInt ( x, y ) ->
            model


view : Model -> Html Msg
view model =
    let
        ( xPos, yPos ) =
            case model.cardPos of
                { x, y } ->
                    ( x, y )

        surface =
            svg
                [ Html.Attributes.style "width" "100%"
                , Html.Attributes.style "height" "100%"
                , Pointer.onDown (\event -> PointerDownMsg event.pointer.offsetPos)
                , Pointer.onUp (\event -> PointerUpMsg event.pointer.offsetPos)
                , Pointer.onMove (\event -> PointerMoveMsg event.pointer.pagePos)
                ]
                [ rect
                    [ width <| px 50
                    , height <| px 50
                    , fill <| Paint.Paint Color.red
                    , x <| px xPos
                    , y <| px yPos
                    ]
                    []
                , circle
                    [ cx (px 25)
                    , cy (px 25)
                    , fill <| Paint.Paint Color.gray
                    , r (px 25)
                    ]
                    []
                ]
    in
    div
        [ Html.Attributes.style "width" "100vw"
        , Html.Attributes.style "height" "100vh"
        ]
        (if model.cardState == InHand then
            [ surface
            ]

         else
            [ surface
            , div
                [ Html.Attributes.style "position"
                    "absolute"
                , Html.Attributes.style
                    "top"
                    (String.fromInt model.helloPos.x ++ "px")
                , Html.Attributes.style
                    "left"
                    (String.fromInt model.helloPos.y ++ "px")
                ]
                [ Html.text "Hello"
                ]
            ]
        )


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
