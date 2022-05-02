
#ifdef VERTEX_SHADER
// ------------------------------------------------------//
// ----------------- VERTEX SHADER ----------------------//
// ------------------------------------------------------//

attribute vec3 a_position; // the position of each vertex
uniform mat4 u_matrixM; // the model matrix of this object
uniform mat4 u_matrixV; // the view matrix of the camera
uniform mat4 u_matrixP; // the projection matrix of the camera
varying vec3 v_normal; 

void main() {
    // TODO: Complete Vertex Shader
    gl_Position = u_matrixP * u_matrixV * u_matrixM * vec4 (a_position, 1);

    v_normal = normalize(a_position.xyz); 
}

#endif
#ifdef FRAGMENT_SHADER
// ------------------------------------------------------//
// ----------------- Fragment SHADER --------------------//
// ------------------------------------------------------//

precision mediump float; //float precision settings
uniform vec3 u_tint;            // the tint color of this object
varying vec3 v_normal; 
uniform samplerCube u_texture; 
void main(void){
    // TODO: Complete Fragment Shader
    gl_FragColor = textureCube(u_texture, normalize(v_normal)); 
}

#endif
