module Main exposing (Model, Msg(..), initialModel, main, update, view)

import Browser
import Html exposing (Html, div)
import Html.Attributes
import Html.Events.Extra.Pointer as Pointer


type alias Model =
    Card


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


initialModel : Model
initialModel =
    { position = { x = 0, y = 0 }
    , state = Free
    , content = "Hello x"
    }


type Msg
    = PointerDownMsg ( Float, Float )
    | PointerUpMsg ( Float, Float )
    | PointerMoveMsg ( Float, Float )
    | PointerDownMsgInt ( Int, Int )


update : Msg -> Model -> Model
update msg model =
    case msg of
        PointerDownMsg ( newX, newY ) ->
            { model
                | position = { x = newX, y = newY }
                , state = InHand
            }

        PointerUpMsg ( newX, newY ) ->
            { model
                | state = Free
            }

        PointerMoveMsg ( newX, newY ) ->
            case model.state of
                InHand ->
                    { model | position = { x = newX, y = newY } }

                Free ->
                    model

        PointerDownMsgInt ( x, y ) ->
            model


view : Model -> Html Msg
view model =
    div
        [ Html.Attributes.style "width" "100vw"
        , Html.Attributes.style "height" "100vh"
        , Pointer.onDown (\event -> PointerDownMsg event.pointer.offsetPos)
        , Pointer.onUp (\event -> PointerUpMsg event.pointer.offsetPos)
        , Pointer.onMove (\event -> PointerMoveMsg event.pointer.pagePos)
        ]
        [ div
            [ Html.Attributes.style "position"
                "absolute"
            , Html.Attributes.style
                "top"
                (String.fromFloat model.position.y ++ "px")
            , Html.Attributes.style
                "left"
                (String.fromFloat model.position.x ++ "px")
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
            [ Html.text model.content
            ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
