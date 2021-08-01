module Main exposing (main)

import Browser exposing (Document)
import Browser.Dom exposing (Viewport, getViewport)
import Browser.Events exposing (onAnimationFrameDelta, onResize)
import Html exposing (Html)
import Html.Attributes exposing (height, style, width)
import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import Mesh
import Shader
import Task
import WebGL exposing (alpha, antialias, clearColor, depth)


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = \model -> { title = "WebGL", body = [ view model ] }
        , subscriptions = subscriptions
        , update = update
        }


type alias Flags =
    ()


type alias Model =
    { t : Float
    , viewport : Vec2
    }


type Msg
    = MsgTick Float
    | MsgResize Vec2


init : Flags -> ( Model, Cmd Msg )
init flags_ =
    ( { t = 0
      , viewport = vec2 0 0
      }
    , Task.perform (\v -> MsgResize <| vec2 v.viewport.width v.viewport.height) getViewport
    )


subscriptions : Model -> Sub Msg
subscriptions model_ =
    Sub.batch
        [ onAnimationFrameDelta MsgTick
        , onResize (\width height -> MsgResize <| vec2 (toFloat width) (toFloat height))
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgTick elapsed ->
            ( { model | t = elapsed + model.t }, Cmd.none )

        MsgResize viewport ->
            ( { model | viewport = viewport }, Cmd.none )


view : Model -> Html Msg
view model =
    WebGL.toHtmlWith
        [ alpha True
        , antialias
        , depth 1
        , clearColor 0 0 0 1
        ]
        [ width <| round <| Vec2.getX model.viewport
        , height <| round <| Vec2.getY model.viewport
        , style "display" "block"
        ]
        [ WebGL.entity
            Shader.vertexShader
            Shader.fragmentShader
            Mesh.helloWorldTriangle
            { viewport = model.viewport
            }
        ]
