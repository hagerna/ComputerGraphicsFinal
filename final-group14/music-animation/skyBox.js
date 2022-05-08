"use strict";

class SkyBox{

    /**
    * Creates a new instance of SkyBox. The given source code will be compiled
    * and assembled into a WebGL ShaderProgram used by this shader to draw models.
    * @param {string} shaderName the source code (text) of this shader programs shader.
    */

	constructor(shaderName, cubeMap, camera){
		this.program = GLUtils.createShaderProgram(shaderName);
        this.cubeMap = cubeMap; 
        this.camera = camera; 
	}

     // Draw the scene.
    drawGeometry() {

        // Tell it to use our program (pair of shaders)
        gl.useProgram(this.program);

        gl.depthMask(false); 



        let positionLocation =    [-0.5, 0.5, 0.5, //Front
          -0.5,-0.5, 0.5,
           0.5,-0.5, 0.5,
           0.5, 0.5, 0.5,

           0.5, 0.5,-0.5, //Back
           0.5,-0.5,-0.5,
          -0.5,-0.5,-0.5,
          -0.5, 0.5,-0.5,

          -0.5, 0.5,-0.5, //Top
          -0.5, 0.5, 0.5,
           0.5, 0.5, 0.5,
           0.5, 0.5,-0.5,

          -0.5,-0.5, 0.5, //Bottom
          -0.5,-0.5,-0.5,
           0.5,-0.5,-0.5,
           0.5,-0.5, 0.5,

           0.5, 0.5, 0.5, //Right
           0.5,-0.5, 0.5,
           0.5,-0.5,-0.5,
           0.5, 0.5,-0.5,

          -0.5, 0.5,-0.5, //Left
          -0.5,-0.5,-0.5,
          -0.5,-0.5, 0.5,
          -0.5, 0.5, 0.5];

                
        gl.enableVertexAttribArray(positionLocation);
        
  
        // creating position buffer 
        let positionBuffer = gl.createBuffer();
        gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);
        gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(positionLocation), gl.STATIC_DRAW);
        let posAttribLoc = gl.getAttribLocation(this.program, "a_position");
        gl.enableVertexAttribArray(posAttribLoc);
        gl.vertexAttribPointer(posAttribLoc,3,gl.FLOAT,false,0,0);

        let viewMatrix = this.camera.viewMatrix;
        let projectionMatrix = this.camera.projectionMatrix;
        // getting a copy with the use of Camera 
        let copy = viewMatrix;  
        copy[12] = 0;
        copy[13] = 0;
        copy[14] = 0;
        copy = M4.invert(copy);

        // Set the uniforms
       let viewMatrixLoc = gl.getUniformLocation(this.program, "u_matrixV");
        gl.uniformMatrix4fv(viewMatrixLoc, false, copy.toFloat32());
        let projMatrixLoc = gl.getUniformLocation(this.program, "u_matrixP");
        gl.uniformMatrix4fv(projMatrixLoc, false, projectionMatrix.toFloat32());


        // set and load cube map as active texture
        gl.activeTexture(gl.TEXTURE0);
        let mainTexture = TextureCache["skyBox"];
        gl.bindTexture(gl.TEXTURE_CUBE_MAP, mainTexture);


        gl.depthMask(true); 

        // Draw the geometry.
        gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);
        gl.drawArrays(gl.TRIANGLES, 0, 1 * 24, gl.UNSIGNED_SHORT, 0);

  }


  
    setGeometry(gl) {
    var positions = new Float32Array(
      [
        -1, -1, 
         1, -1, 
        -1,  1, 
        -1,  1,
         1, -1,
         1,  1,
      ]);
    gl.bufferData(gl.ARRAY_BUFFER, positions, gl.STATIC_DRAW);
  }


} 
