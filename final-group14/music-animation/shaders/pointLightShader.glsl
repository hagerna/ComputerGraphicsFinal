
#ifdef VERTEX_SHADER
// ------------------------------------------------------//
// ----------------- VERTEX SHADER ----------------------//
// ------------------------------------------------------//

attribute vec3 a_position; // the position of each vertex
attribute vec3 a_normal;   // the surface normal of each vertex

//TODO: Add a_texcoord attribute
attribute vec2 a_texcoord; // the texture coordinate of each vertex
uniform mat4 u_matrixM; // the model matrix of this object
uniform mat4 u_matrixV; // the view matrix of the camera
uniform mat4 u_matrixP; // the projection matrix of the camera
uniform mat3 u_matrixInvTransM;
varying vec3 v_normal;    // normal to forward to the fragment shader

//Point Light Additions
uniform mat4 u_world;
uniform vec3 u_lightWorldPosition;
varying vec3 v_surfaceToLight;

//TODO: Add v_texcoord varying
varying vec2 v_texcoord;

void main() {
    v_normal = normalize(u_matrixInvTransM * a_normal); // set normal data for fragment shader
    
    //TODO: Transfer texCoord attribute value to varying
    v_texcoord = a_texcoord;

    vec3 surfaceWorldPosition = (u_world * vec4 (a_position, 1)).xyz;
    v_surfaceToLight = u_lightWorldPosition - surfaceWorldPosition;

    gl_Position = u_matrixP * u_matrixV * u_matrixM * vec4 (a_position, 1);
}

#endif
#ifdef FRAGMENT_SHADER
// ------------------------------------------------------//
// ----------------- Fragment SHADER --------------------//
// ------------------------------------------------------//

precision highp float; //float precision settings
uniform vec3 u_tint;            // the tint color of this object
uniform vec3 u_pointLightColor; // light color
uniform vec3 u_ambientColor;    // intensity of ambient light
varying vec3 v_normal;  // normal from the vertex shader
varying vec3 v_surfaceToLight;


varying vec2 v_texcoord;

uniform sampler2D u_mainTex;

void main(void){
    // calculate point lighting
    vec3 normal = normalize(v_normal);
    vec3 surfaceToLightDirection = normalize(v_surfaceToLight);
    float light = max(0.0, dot(normal, surfaceToLightDirection));
    vec3 lightColor = u_pointLightColor * light;
    vec3 ambientDiffuse = u_ambientColor + lightColor;
    ambientDiffuse = clamp(ambientDiffuse, vec3(0.0,0.0,0.0), vec3(1.0,1.0,1.0));

    //TODO: Add texture color sampling
    vec3 textureColor = texture2D(u_mainTex, v_texcoord).rgb;
    //TODO: Blend texture color with tint color for new baseColor
    vec3 baseColor = textureColor * u_tint;
    vec3 finalColor = ambientDiffuse * baseColor; // apply lighting to color

    gl_FragColor = vec4(finalColor, 1);
}

#endif
