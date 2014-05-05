attribute vec3 a_position;
attribute mat4 a_mvpMatrix;

uniform mat4 u_projectionMatrix;

void main()
{
	v_position = vec3(a_mvpMatrix * vec4(a_position, 1.0));
	
    gl_Position = u_projectionMatrix * vec4(v_position, 1.0);
}