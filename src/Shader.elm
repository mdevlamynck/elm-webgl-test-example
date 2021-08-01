module Shader exposing (..)

import Math.Vector3 exposing (Vec3)
import Types exposing (Uniform, Vertex)
import WebGL exposing (Mesh, Shader)


vertexShader : Shader Vertex Uniform { vcolor : Vec3 }
vertexShader =
    [glsl|
        attribute vec2 position;
        attribute vec3 color;
        uniform vec2 viewport;
        varying vec3 vcolor;

        vec2 adaptToAspectRatio(vec2 pos) {
            float ratio;
            vec2 clipspace;

            if (viewport.x > viewport.y) {
                ratio = viewport.y / viewport.x;
                clipspace.y = pos.y;
                clipspace.x = pos.x * ratio;
            } else {
                ratio = viewport.x / viewport.y;
                clipspace.x = pos.x;
                clipspace.y = pos.y * ratio;
            }

            return clipspace;
        }

        void main () {
            gl_Position = vec4(adaptToAspectRatio(position), 0.0, 1.0);
            vcolor = color;
        }
    |]


fragmentShader : Shader {} Uniform { vcolor : Vec3 }
fragmentShader =
    [glsl|
        precision mediump float;
        varying vec3 vcolor;

        void main () {
            gl_FragColor = vec4(vcolor, 1.0);
        }
    |]
