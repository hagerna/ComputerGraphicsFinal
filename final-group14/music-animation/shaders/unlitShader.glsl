
#ifdef VERTEX_SHADER
// ------------------------------------------------------//
// ----------------- VERTEX SHADER ----------------------//
// ------------------------------------------------------//

attribute vec3 a_position; // the position of each vertex
attribute vec2 a_texcoord; // the texture coordinate of each vertex

uniform mat4 u_matrixM; // the model matrix of this object
uniform mat4 u_matrixV; // the view matrix of the camera
uniform mat4 u_matrixP; // the projection matrix of the camera

varying vec2 v_texcoord;

void main() {
    v_texcoord = a_texcoord;
    gl_Position = u_matrixP * u_matrixV * u_matrixM * vec4 (a_position, 1);
}

#endif
#ifdef FRAGMENT_SHADER
// ------------------------------------------------------//
// ----------------- Fragment SHADER --------------------//
// ------------------------------------------------------//

precision highp float; //float precision settings
uniform vec3 u_tint;            // the tint color of this object
varying vec2 v_texcoord;

uniform sampler2D u_mainTex;

void main(void){
    vec3 textureColor = texture2D(u_mainTex, v_texcoord).rgb;
    vec3 finalColor = textureColor * u_tint;
    gl_FragColor = vec4(finalColor, 1);
}

#endif
