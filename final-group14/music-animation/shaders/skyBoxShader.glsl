
#ifdef VERTEX_SHADER
// ------------------------------------------------------//
// ----------------- VERTEX SHADER ----------------------//
// ------------------------------------------------------//

attribute vec3 a_position; // the position of each vertex
attribute vec2 a_texcoord;
uniform mat4 u_matrixM; // the model matrix of this object
uniform mat4 u_matrixV; // the view matrix of the camera
uniform mat4 u_matrixP; // the projection matrix of the camera
varying vec3 v_normal; 
varying vec2 v_texcoord;

void main() {
    v_normal = normalize(a_position.xyz); 

    v_texcoord = a_texcoord;

    gl_Position = u_matrixP * u_matrixV * u_matrixM * vec4 (a_position, 1);


}

#endif
#ifdef FRAGMENT_SHADER
// ------------------------------------------------------//
// ----------------- Fragment SHADER --------------------//
// ------------------------------------------------------//

precision mediump float; //float precision settings
varying vec2 v_texcoord;
varying vec3 v_normal; 
uniform samplerCube u_texture; 
void main(void){
    gl_FragColor = textureCube(u_texture, normalize(v_normal)); 
}

#endif
