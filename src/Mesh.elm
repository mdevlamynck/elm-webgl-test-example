module Mesh exposing (..)

import Math.Vector2 exposing (Vec2, vec2)
import Math.Vector3 exposing (Vec3, vec3)
import Types exposing (Vertex)
import WebGL exposing (Mesh)


helloWorldTriangle : Mesh Vertex
helloWorldTriangle =
    WebGL.triangles
        [ ( Vertex (vec2 0 0.5) (vec3 1 0 0)
          , Vertex (vec2 -0.5 -0.5) (vec3 0 1 0)
          , Vertex (vec2 0.5 -0.5) (vec3 0 0 1)
          )
        ]


redTriangle : Mesh Vertex
redTriangle =
    WebGL.triangles
        [ ( Vertex (vec2 0 0.5) (vec3 1 0 0)
          , Vertex (vec2 -0.5 -0.5) (vec3 1 0 0)
          , Vertex (vec2 0.5 -0.5) (vec3 1 0 0)
          )
        ]
