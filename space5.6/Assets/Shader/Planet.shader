// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:0,lgpr:1,limd:3,spmd:0,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:3138,x:32947,y:32431,varname:node_3138,prsc:2|diff-2275-OUT,spec-7823-OUT,gloss-4321-OUT,normal-7875-RGB,emission-5870-OUT;n:type:ShaderForge.SFN_Tex2d,id:4658,x:30405,y:32354,ptovrint:False,ptlb:Albedo,ptin:_Albedo,varname:node_4658,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:72ba01dab3185214982b48accb2d9664,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:7111,x:31162,y:33360,ptovrint:False,ptlb:Specular,ptin:_Specular,varname:node_7111,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6a178afe4ebbc8543ae35a463a8966f4,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:7173,x:30315,y:32667,ptovrint:False,ptlb:Clouds texture,ptin:_Cloudstexture,varname:node_7173,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:e1b95afc12b486448abe975632e539cf,ntxv:0,isnm:False|UVIN-4572-UVOUT;n:type:ShaderForge.SFN_Add,id:8198,x:31158,y:32719,varname:node_8198,prsc:2|A-120-OUT,B-7482-OUT;n:type:ShaderForge.SFN_Tex2d,id:7875,x:31743,y:33764,ptovrint:False,ptlb:Normal map,ptin:_Normalmap,varname:node_7875,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:0b5ac22ada0e4fd43ab69e9331139f3c,ntxv:0,isnm:True;n:type:ShaderForge.SFN_Panner,id:4572,x:30088,y:32667,cmnt:Cloud speed,varname:node_4572,prsc:2,spu:0.0015,spv:0|UVIN-8432-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:8432,x:29851,y:32667,varname:node_8432,prsc:2,uv:0;n:type:ShaderForge.SFN_Color,id:6934,x:30315,y:32894,ptovrint:False,ptlb:Clouds color,ptin:_Cloudscolor,varname:node_6934,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:2318,x:30558,y:32827,varname:node_2318,prsc:2|A-7173-A,B-6934-RGB;n:type:ShaderForge.SFN_SwitchProperty,id:7482,x:30786,y:32779,ptovrint:False,ptlb:Clouds,ptin:_Clouds,cmnt:Clouds,varname:node_7482,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-5866-OUT,B-2318-OUT;n:type:ShaderForge.SFN_Vector3,id:5866,x:30546,y:32652,varname:node_5866,prsc:2,v1:0,v2:0,v3:0;n:type:ShaderForge.SFN_LightVector,id:2387,x:31012,y:31906,varname:node_2387,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:619,x:31012,y:32048,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:3504,x:31228,y:31986,varname:node_3504,prsc:2,dt:0|A-2387-OUT,B-619-OUT;n:type:ShaderForge.SFN_Multiply,id:1870,x:32137,y:32355,varname:node_1870,prsc:2|A-3504-OUT,B-8198-OUT;n:type:ShaderForge.SFN_Tex2d,id:2895,x:30993,y:31349,ptovrint:False,ptlb:Emissive,ptin:_Emissive,cmnt:Cities,varname:_Albedo_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:e761d1b5f99e4c840b58081a41de20d6,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:1758,x:31264,y:31370,varname:node_1758,prsc:2|A-2895-RGB,B-5761-OUT;n:type:ShaderForge.SFN_OneMinus,id:5761,x:31399,y:31808,varname:node_5761,prsc:2|IN-3504-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:9266,x:31895,y:31193,ptovrint:False,ptlb:Night emissive (cities) ,ptin:_Nightemissivecities,cmnt:Cities emissive,varname:node_9266,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True|A-1904-OUT,B-3487-OUT;n:type:ShaderForge.SFN_Vector3,id:1904,x:31636,y:31134,varname:node_1904,prsc:2,v1:0,v2:0,v3:0;n:type:ShaderForge.SFN_Fresnel,id:2636,x:31651,y:31781,varname:node_2636,prsc:2|EXP-9953-OUT;n:type:ShaderForge.SFN_Add,id:5870,x:32445,y:31882,varname:node_5870,prsc:2|A-9266-OUT,B-1027-OUT;n:type:ShaderForge.SFN_Multiply,id:4731,x:31814,y:31919,varname:node_4731,prsc:2|A-2636-OUT,B-3504-OUT;n:type:ShaderForge.SFN_Slider,id:9953,x:31320,y:31716,ptovrint:False,ptlb:Sub Atmosphere power,ptin:_SubAtmospherepower,varname:node_9953,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:1.983384,max:10;n:type:ShaderForge.SFN_SwitchProperty,id:8533,x:32014,y:31900,ptovrint:False,ptlb:Sub Atmosphere,ptin:_SubAtmosphere,varname:node_8533,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True|A-2217-OUT,B-4731-OUT;n:type:ShaderForge.SFN_Vector3,id:2217,x:31814,y:32104,varname:node_2217,prsc:2,v1:0,v2:0,v3:0;n:type:ShaderForge.SFN_Color,id:8608,x:32074,y:32081,ptovrint:False,ptlb:Sub atmosphere color,ptin:_Subatmospherecolor,varname:node_8608,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.7058823,c2:0.8174442,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:1027,x:32297,y:31975,varname:node_1027,prsc:2|A-8533-OUT,B-8608-RGB;n:type:ShaderForge.SFN_Multiply,id:4357,x:31429,y:31279,varname:node_4357,prsc:2|A-881-OUT,B-1758-OUT;n:type:ShaderForge.SFN_Vector1,id:881,x:31288,y:31241,varname:node_881,prsc:2,v1:2;n:type:ShaderForge.SFN_Multiply,id:3487,x:31636,y:31243,varname:node_3487,prsc:2|A-8984-RGB,B-4357-OUT;n:type:ShaderForge.SFN_Color,id:8984,x:31429,y:31134,ptovrint:False,ptlb:City color,ptin:_Citycolor,cmnt:City color,varname:node_8984,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0.7241379,c3:0,c4:1;n:type:ShaderForge.SFN_Tex2d,id:6971,x:31693,y:30676,cmnt:Sunset color,varname:node_6971,prsc:2,tex:3c94491068797e54b9d16576eeb33a8c,ntxv:0,isnm:False|UVIN-2625-OUT,TEX-6863-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:6863,x:31488,y:30770,ptovrint:False,ptlb:Look up ramp (Sunset),ptin:_LookuprampSunset,varname:node_6863,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:3c94491068797e54b9d16576eeb33a8c,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Append,id:2625,x:31474,y:30603,varname:node_2625,prsc:2|A-362-OUT,B-6305-OUT;n:type:ShaderForge.SFN_Vector1,id:6305,x:31324,y:30736,varname:node_6305,prsc:2,v1:0;n:type:ShaderForge.SFN_Dot,id:362,x:31121,y:30734,varname:node_362,prsc:2,dt:0|A-1208-OUT,B-8573-OUT;n:type:ShaderForge.SFN_LightVector,id:1208,x:30919,y:30632,varname:node_1208,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:8573,x:30919,y:30816,prsc:2,pt:False;n:type:ShaderForge.SFN_Multiply,id:2275,x:32644,y:31793,varname:node_2275,prsc:2|A-6971-RGB,B-1870-OUT;n:type:ShaderForge.SFN_Multiply,id:120,x:30705,y:32322,cmnt:Albedo,varname:node_120,prsc:2|A-517-RGB,B-4658-RGB;n:type:ShaderForge.SFN_Color,id:517,x:30405,y:32173,ptovrint:False,ptlb:Albedo color,ptin:_Albedocolor,varname:node_517,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Slider,id:4321,x:31364,y:33487,ptovrint:False,ptlb:Specular power,ptin:_Specularpower,varname:node_4321,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.382126,max:1;n:type:ShaderForge.SFN_ConstantClamp,id:7823,x:31688,y:33135,varname:node_7823,prsc:2,min:0,max:0.1|IN-9153-OUT;n:type:ShaderForge.SFN_Multiply,id:9153,x:31423,y:33214,varname:node_9153,prsc:2|A-8727-RGB,B-7111-RGB;n:type:ShaderForge.SFN_Color,id:8727,x:31162,y:33151,ptovrint:False,ptlb:Specular color,ptin:_Specularcolor,varname:node_8727,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5912089,c2:0.9095908,c3:0.9926471,c4:1;proporder:8533-8608-9953-517-4658-7111-8727-4321-7875-7482-6934-7173-9266-8984-2895-6863;pass:END;sub:END;*/

Shader "Exo-Planets/Planet" {
    Properties {
        [MaterialToggle] _SubAtmosphere ("Sub Atmosphere", Float ) = 0
        _Subatmospherecolor ("Sub atmosphere color", Color) = (0.7058823,0.8174442,1,1)
        _SubAtmospherepower ("Sub Atmosphere power", Range(1, 10)) = 1.983384
        _Albedocolor ("Albedo color", Color) = (1,1,1,1)
        _Albedo ("Albedo", 2D) = "white" {}
        _Specular ("Specular", 2D) = "white" {}
        _Specularcolor ("Specular color", Color) = (0.5912089,0.9095908,0.9926471,1)
        _Specularpower ("Specular power", Range(0, 1)) = 0.382126
        _Normalmap ("Normal map", 2D) = "white" {}
        [MaterialToggle] _Clouds ("Clouds", Float ) = 0
        _Cloudscolor ("Clouds color", Color) = (0.5,0.5,0.5,1)
        _Cloudstexture ("Clouds texture", 2D) = "white" {}
        [MaterialToggle] _Nightemissivecities ("Night emissive (cities) ", Float ) = 0
        _Citycolor ("City color", Color) = (1,0.7241379,0,1)
        _Emissive ("Emissive", 2D) = "white" {}
        _LookuprampSunset ("Look up ramp (Sunset)", 2D) = "white" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform sampler2D _Albedo; uniform float4 _Albedo_ST;
            uniform sampler2D _Specular; uniform float4 _Specular_ST;
            uniform sampler2D _Cloudstexture; uniform float4 _Cloudstexture_ST;
            uniform sampler2D _Normalmap; uniform float4 _Normalmap_ST;
            uniform float4 _Cloudscolor;
            uniform fixed _Clouds;
            uniform sampler2D _Emissive; uniform float4 _Emissive_ST;
            uniform fixed _Nightemissivecities;
            uniform float _SubAtmospherepower;
            uniform fixed _SubAtmosphere;
            uniform float4 _Subatmospherecolor;
            uniform float4 _Citycolor;
            uniform sampler2D _LookuprampSunset; uniform float4 _LookuprampSunset_ST;
            uniform float4 _Albedocolor;
            uniform float _Specularpower;
            uniform float4 _Specularcolor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos(v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _Normalmap_var = UnpackNormal(tex2D(_Normalmap,TRANSFORM_TEX(i.uv0, _Normalmap)));
                float3 normalLocal = _Normalmap_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = _Specularpower;
                float specPow = exp2( gloss * 10.0+1.0);
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
////// Specular:
                float NdotL = max(0, dot( normalDirection, lightDirection ));
                float LdotH = max(0.0,dot(lightDirection, halfDirection));
                float4 _Specular_var = tex2D(_Specular,TRANSFORM_TEX(i.uv0, _Specular));
                float3 specularColor = clamp((_Specularcolor.rgb*_Specular_var.rgb),0,0.1);
                float specularMonochrome = max( max(specularColor.r, specularColor.g), specularColor.b);
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
                float NdotH = max(0.0,dot( normalDirection, halfDirection ));
                float VdotH = max(0.0,dot( viewDirection, halfDirection ));
                float visTerm = SmithBeckmannVisibilityTerm( NdotL, NdotV, 1.0-gloss );
                float normTerm = max(0.0, NDFBlinnPhongNormalizedTerm(NdotH, RoughnessToSpecPower(1.0-gloss)));
                float specularPBL = max(0, (NdotL*visTerm*normTerm) * (UNITY_PI / 4) );
                float3 directSpecular = (floor(attenuation) * _LightColor0.xyz) * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularPBL*lightColor*FresnelTerm(specularColor, LdotH);
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float3 directDiffuse = ((1 +(fd90 - 1)*pow((1.00001-NdotL), 5)) * (1 + (fd90 - 1)*pow((1.00001-NdotV), 5)) * NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                float2 node_2625 = float2(dot(lightDirection,i.normalDir),0.0);
                float4 node_6971 = tex2D(_LookuprampSunset,TRANSFORM_TEX(node_2625, _LookuprampSunset)); // Sunset color
                float node_3504 = dot(lightDirection,i.normalDir);
                float4 _Albedo_var = tex2D(_Albedo,TRANSFORM_TEX(i.uv0, _Albedo));
                float4 node_4732 = _Time + _TimeEditor;
                float2 node_4572 = (i.uv0+node_4732.g*float2(0.0015,0)); // Cloud speed
                float4 _Cloudstexture_var = tex2D(_Cloudstexture,TRANSFORM_TEX(node_4572, _Cloudstexture));
                float3 diffuseColor = (node_6971.rgb*(node_3504*((_Albedocolor.rgb*_Albedo_var.rgb)+lerp( float3(0,0,0), (_Cloudstexture_var.a*_Cloudscolor.rgb), _Clouds ))));
                diffuseColor *= 1-specularMonochrome;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float4 _Emissive_var = tex2D(_Emissive,TRANSFORM_TEX(i.uv0, _Emissive)); // Cities
                float3 emissive = (lerp( float3(0,0,0), (_Citycolor.rgb*(2.0*(_Emissive_var.rgb*(1.0 - node_3504)))), _Nightemissivecities )+(lerp( float3(0,0,0), (pow(1.0-max(0,dot(normalDirection, viewDirection)),_SubAtmospherepower)*node_3504), _SubAtmosphere )*_Subatmospherecolor.rgb));
/// Final Color:
                float3 finalColor = diffuse + specular + emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
