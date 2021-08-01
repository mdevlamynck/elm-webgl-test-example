module HelloWorld exposing (main)

import Html exposing (Html)
import Html.Attributes exposing (height, width)
import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import Mesh
import Shader
import WebGL exposing (alpha, antialias, clearColor, depth)


main : Html msg
main =
    let
        viewport =
            vec2 800 600
    in
    WebGL.toHtmlWith
        [ alpha True
        , antialias
        , depth 1
        , clearColor 0 0 0 1
        ]
        [ width <| round <| Vec2.getX viewport
        , height <| round <| Vec2.getY viewport
        ]
        [ WebGL.entity
            Shader.vertexShader
            Shader.fragmentShader
            Mesh.helloWorldTriangle
            { viewport = viewport
            }
        ]
