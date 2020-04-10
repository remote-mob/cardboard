module Main exposing (Model, Msg(..), initialModel, main, update, view)

import Browser
import Color
import Html exposing (Html, div)
import Html.Attributes
import Html.Events.Extra.Pointer as Pointer
import TypedSvg exposing (rect, svg)
import TypedSvg.Attributes exposing (fill, height, width, x, y)
import TypedSvg.Types as Paint exposing (Paint, px)


type alias Model =
    Maybe { x : Float, y : Float }


initialModel : Model
initialModel =
    Nothing


type Msg
    = PointerDownMsg ( Float, Float )
    | PointerUpMsg ( Float, Float )
    | PointerMoveMsg ( Float, Float )


update : Msg -> Model -> Model
update msg model =
    let
        active =
            case model of
                Just _ ->
                    True

                Nothing ->
                    False
    in
    case msg of
        PointerDownMsg ( newX, newY ) ->
            Just { x = newX, y = newY }

        PointerUpMsg ( newX, newY ) ->
            Nothing

        PointerMoveMsg ( newX, newY ) ->
            if active then
                Just { x = newX, y = newY }

            else
                Nothing


view : Model -> Html Msg
view model =
    let
        ( xPos, yPos ) =
            case model of
                Just { x, y } ->
                    ( x, y )

                Nothing ->
                    ( 0, 0 )
    in
    svg
        [ height <| px 400
        , width <| px 400
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
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
