module Main exposing (Model, Msg(..), initialModel, main, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes
import Html.Events exposing (onClick)
import Html.Events.Extra.Pointer as Pointer


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
    div
        [ Pointer.onDown (\event -> PointerDownMsg event.pointer.offsetPos)
        , Pointer.onUp (\event -> PointerUpMsg event.pointer.offsetPos)
        , Pointer.onMove (\event -> PointerMoveMsg event.pointer.pagePos)
        , Html.Attributes.style "height" "400px"
        , Html.Attributes.style "width" "400px"
        , Html.Attributes.style "background-color" "red"
        , Html.Attributes.style "touch-action" "none"
        ]
        [ div
            [ Html.Attributes.style "top" <| (String.fromFloat yPos ++ "px")
            , Html.Attributes.style "left" <| (String.fromFloat xPos ++ "px")
            , Html.Attributes.style "position" "absolute"
            , Html.Attributes.style "background-color" "white"
            , Html.Attributes.style "height" "50px"
            , Html.Attributes.style "width" "50px"
            ]
            [ div
                [ Html.Attributes.style "background-color" "gray"
                , Html.Attributes.style "width" "25px"
                , Html.Attributes.style "height" "50px"
                ]
                []
            ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
