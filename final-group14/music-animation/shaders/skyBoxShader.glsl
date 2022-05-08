
#ifdef VERTEX_SHADER
// ------------------------------------------------------//
// ----------------- VERTEX SHADER ----------------------//
// ------------------------------------------------------//

attribute vec3 a_position;
varying vec3 v_position;
uniform mat4 u_matrixP; 
uniform mat4 u_matrixV; 
uniform mat4 u_viewDirectionProjectionInverse; 

void main() {
  v_position = a_position;
  gl_Position = u_matrixP * u_matrixV * vec4 (a_position, 1);
}

#endif
#ifdef FRAGMENT_SHADER
// ------------------------------------------------------//
// ----------------- Fragment SHADER --------------------//
// ------------------------------------------------------//

precision mediump float;
 
uniform samplerCube u_skybox;
varying vec3 v_position;

void main() {
    gl_FragColor = textureCube(u_skybox, v_position);
}

#endif
