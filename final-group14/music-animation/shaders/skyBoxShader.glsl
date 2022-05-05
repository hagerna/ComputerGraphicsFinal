
#ifdef VERTEX_SHADER
// ------------------------------------------------------//
// ----------------- VERTEX SHADER ----------------------//
// ------------------------------------------------------//

attribute vec3 a_position;
varying vec3 v_position;
uniform mat4 u_matrixP; 
uniform mat4 u_matrixV; 

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
uniform mat4 u_viewDirectionProjectionInverse;
varying vec3 v_position;

void main() {
    vec3 t = u_viewDirectionProjectionInverse * vec4(v_position,1);
    vec3 sampleColor = textureCube(u_skybox, normalize(t)).rgb;
    gl_FragColor = textureCube(sampleColor, 1);
}

#endif
