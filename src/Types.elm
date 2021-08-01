module Types exposing (..)

import Math.Vector2 exposing (Vec2)
import Math.Vector3 exposing (Vec3)


type alias Vertex =
    { position : Vec2
    , color : Vec3
    }


type alias Uniform =
    { viewport : Vec2
    }
