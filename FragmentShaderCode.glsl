#version 430

out vec4 daColor;

in vec2 UV;
in vec3 normalWorld;
in vec3 vertexPositionWorld;

uniform sampler2D myTextureSampler;
uniform vec4 ambientLight;
uniform vec4 diffuseLight;
uniform vec4 specularLight;
uniform vec3 lightPositionWorld;
uniform vec4 eyePositionWorld;

uniform vec4 ambientLight2;
uniform vec4 diffuseLight2;
uniform vec4 specularLight2;
uniform vec3 lightPositionWorld2;
uniform vec4 eyePositionWorld2;

void main()
{

	//light source 1
	vec3 color = texture( myTextureSampler, UV ).rgb;
	vec3 lightVectorWorld = normalize(lightPositionWorld - vertexPositionWorld);
	float brightness = dot(lightVectorWorld, normalize(normalWorld));
	float distance = dot((lightPositionWorld - vertexPositionWorld),(lightPositionWorld - vertexPositionWorld));
	vec4 diffuseLightFin = vec4(brightness, brightness, brightness, 1.0) * diffuseLight;// * 1/distance * 2;

	vec4 MaterialAmbientColor = vec4(texture(myTextureSampler, UV ).rgb, 1.0);
	vec4 MaterialDiffuseColor = vec4(texture(myTextureSampler, UV ).rgb, 1.0);
	vec4 MaterialSpecularColor = vec4(0.7,0.7,0.7, 1.0);

	vec3 reflectedLightVectorWorld = reflect(-lightVectorWorld, normalWorld);
	vec3 eyeVectorWorld = normalize(eyePositionWorld.xyz - vertexPositionWorld);
	float s = clamp(dot(reflectedLightVectorWorld, eyeVectorWorld),0,1) ;
	s = pow(s, 20);
	vec4 specularLightFin = vec4(s,s,s,1) * specularLight;

	//light source 2
	vec3 lightVectorWorld2 = normalize(lightPositionWorld2 - vertexPositionWorld);
	float brightness2 = dot(lightVectorWorld2, normalize(normalWorld));
	float distance2 = dot((lightPositionWorld2 - vertexPositionWorld),(lightPositionWorld2 - vertexPositionWorld));
	vec4 diffuseLightFin2 = vec4(brightness2, brightness2, brightness2, 1.0) * diffuseLight2;// * 1/distance * 2;

	vec3 reflectedLightVectorWorld2 = reflect(-lightVectorWorld2, normalWorld);
	float s2 = clamp(dot(reflectedLightVectorWorld2, eyeVectorWorld),0,1) ;
	s2 = pow(s2, 20);
	vec4 specularLightFin2 = vec4(s,s,s,1) * specularLight2;

	daColor = MaterialAmbientColor * ambientLight +  clamp(MaterialDiffuseColor* diffuseLightFin,0,1) + MaterialSpecularColor * specularLightFin 
	+  clamp(MaterialDiffuseColor* diffuseLightFin2,0,1) + MaterialSpecularColor * specularLightFin2;
}