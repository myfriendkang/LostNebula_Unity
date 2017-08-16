// Upgrade NOTE: replaced 'UNITY_INSTANCE_ID' with 'UNITY_VERTEX_INPUT_INSTANCE_ID'

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/Planet"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Subatmospherecolor("Sub atmosphere color", Color) = (1,1,1,0)
		_Subatmospherepower("Sub atmosphere power", Range( 0 , 10)) = 5
		_Subatmosphereglobalintensity("Sub atmosphere global intensity", Range( 0 , 5)) = 1
		_Albedo("Albedo", 2D) = "white" {}
		_Albedocolor("Albedo color", Color) = (1,1,1,0)
		_Desaturation("Desaturation", Range( 0 , 1)) = 0
		_Normalmap("Normal map", 2D) = "bump" {}
		_Normalintensity("Normal intensity", Range( 0 , 1)) = 0
		_Emissivecities("Emissive (cities)", 2D) = "white" {}
		_Citiescolor("Cities color", Color) = (1,0.815662,0.559,0)
		_Citiesintensity("Cities intensity", Range( 0 , 5)) = 0
		_watermask("water mask", 2D) = "white" {}
		_Gloss("Gloss", Range( 0 , 1)) = 0.81
		_LookupSunset("Lookup Sunset", 2D) = "white" {}
		_CloudsAlpha("Clouds (Alpha)", 2D) = "white" {}
		_cloudscolor("clouds color", Color) = (0.4338235,0.4338235,0.4338235,0)
		_Cloudspeed("Cloud speed", Range( 0 , 0.2)) = 0.2
		[Toggle]_Desactivateclouds("Desactivate clouds", Float) = 0
		_Ambiantcolor("Ambiant color", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite On
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float2 texcoord_0;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _Normalmap;
		uniform float4 _Normalmap_ST;
		uniform float _Desactivateclouds;
		uniform sampler2D _CloudsAlpha;
		uniform float _Cloudspeed;
		uniform float _Normalintensity;
		uniform sampler2D _LookupSunset;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _Albedocolor;
		uniform float4 _cloudscolor;
		uniform float _Desaturation;
		uniform float _Subatmosphereglobalintensity;
		uniform float _Subatmospherepower;
		uniform float4 _Subatmospherecolor;
		uniform sampler2D _Emissivecities;
		uniform float4 _Emissivecities_ST;
		uniform float4 _Citiescolor;
		uniform float _Citiesintensity;
		uniform float4 _Ambiantcolor;
		uniform float _Gloss;
		uniform sampler2D _watermask;
		uniform float4 _watermask_ST;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.texcoord_0.xy = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normalmap = i.uv_texcoord * _Normalmap_ST.xy + _Normalmap_ST.zw;
			float4 appendResult41 = float4( _Cloudspeed , 0.0 , 0 , 0 );
			float4 temp_cast_2 = tex2D( _CloudsAlpha,( float4( i.texcoord_0, 0.0 , 0.0 ) + ( appendResult41 * _Time.x ) ).xy).a;
			o.Normal = lerp( float3(0,0,1) , UnpackNormal( tex2D( _Normalmap,uv_Normalmap) ) , ( ( 1.0 - lerp(temp_cast_2,float4(0,0,0,0),_Desactivateclouds) ) * _Normalintensity ).r );
			float4 appendResult97 = float4( dot( UnityWorldSpaceLightDir( i.worldPos ) , WorldNormalVector( i, float3(0,0,1) ) ) , 0.0 , 0 , 0 );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 tex2DNode26 = tex2D( _CloudsAlpha,( float4( i.texcoord_0, 0.0 , 0.0 ) + ( appendResult41 * _Time.x ) ).xy);
			float4 temp_cast_8 = tex2DNode26.a;
			float3 desaturateVar142 = lerp( lerp( ( tex2D( _Albedo,uv_Albedo) * _Albedocolor ) , _cloudscolor , lerp(temp_cast_8,float4(0,0,0,0),_Desactivateclouds).r ).rgb,dot(lerp( ( tex2D( _Albedo,uv_Albedo) * _Albedocolor ) , _cloudscolor , lerp(temp_cast_8,float4(0,0,0,0),_Desactivateclouds).r ).rgb,float3(0.299,0.587,0.114)),_Desaturation);
			o.Albedo = ( tex2D( _LookupSunset,appendResult97.xy) * float4( desaturateVar142 , 0.0 ) ).xyz;
			float3 worldViewDir = normalize( UnityWorldSpaceViewDir( i.worldPos ) );
			float fresnelFinalVal9 = (0.0 + _Subatmosphereglobalintensity*pow( 1.0 - dot( WorldNormalVector( i, float3(0,0,1) ), worldViewDir ) , _Subatmospherepower));
			float2 uv_Emissivecities = i.uv_texcoord * _Emissivecities_ST.xy + _Emissivecities_ST.zw;
			o.Emission = ( ( clamp( ( ( dot( WorldNormalVector( i, float3(0,0,1) ) , UnityWorldSpaceLightDir( i.worldPos ) ) * fresnelFinalVal9 ) * _Subatmospherecolor ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) ) + ( ( tex2DNode26.a * ( clamp( pow( ( 1.0 - dot( WorldNormalVector( i, float3(0,0,1) ) , UnityWorldSpaceLightDir( i.worldPos ) ) ) , 5.0 ) , 0.0 , 1.0 ) * ( tex2D( _Emissivecities,uv_Emissivecities) * _Citiescolor ) ) ) * _Citiesintensity ) ) + ( _Ambiantcolor * clamp( pow( ( 1.0 - dot( WorldNormalVector( i, float3(0,0,1) ) , UnityWorldSpaceLightDir( i.worldPos ) ) ) , 5.0 ) , 0.0 , 1.0 ) ) ).rgb;
			float4 temp_cast_15 = tex2DNode26.a;
			float2 uv_watermask = i.uv_texcoord * _watermask_ST.xy + _watermask_ST.zw;
			float4 tex2DNode82 = tex2D( _watermask,uv_watermask);
			float4 temp_cast_17 = tex2DNode82.a;
			o.Smoothness = ( ( ( 1.0 - lerp(temp_cast_15,float4(0,0,0,0),_Desactivateclouds) ) * _Gloss ) * clamp( ( temp_cast_17 + tex2DNode82 ) , float4( 0,0,0,0 ) , float4( 1,1,1,1 ) ) ).x;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha noambient nolightmap  nodynlightmap nodirlightmap nofog vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			# include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 worldPos : TEXCOORD6;
				float4 tSpace0 : TEXCOORD1;
				float4 tSpace1 : TEXCOORD2;
				float4 tSpace2 : TEXCOORD3;
				float4 texcoords01 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.texcoords01 = float4( v.texcoord.xy, v.texcoord1.xy );
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			fixed4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.texcoords01.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=6001
2567;29;1666;974;91.87271;400.0814;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;124;-994.7861,39.58629;Float;False;1512.673;621.3784;Sub atmosphere;11;74;13;15;22;9;19;12;11;7;8;49;
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;8;-906.8358,235.8548;Float;False;0;FLOAT;0.0;False;FLOAT3
Node;AmplifyShaderEditor.WorldNormalVector;49;-841.9657,93.87229;Float;False;0;FLOAT3;0,0,0;False;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.DotProductOpNode;7;-616.2434,106.8931;Float;True;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0;False;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;122;-1596.469,-616.8764;Float;False;828;523.9995;Cloud movement;7;42;28;33;41;32;34;40;
Node;AmplifyShaderEditor.OneMinusNode;50;-359.2102,721.9059;Float;False;0;FLOAT;0,0,0,0;False;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;128;-1101.071,877.0961;Float;False;1478.625;776.8639;Cities in the dark;12;71;45;47;70;46;72;48;69;68;132;135;141;
Node;AmplifyShaderEditor.RangedFloatNode;42;-1525.469,-406.8769;Float;False;Constant;_Verticalspeed0;Vertical speed (0);5;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.WireNode;135;-229.4077,950.0291;Float;False;0;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;28;-1530.469,-486.8766;Float;False;Property;_Cloudspeed;Cloud speed;16;0;0.2;0;0.2;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;71;-939.8417,1167.918;Float;False;Constant;_Float0;Float 0;10;0;5;0;0;FLOAT
Node;AmplifyShaderEditor.WireNode;132;-815.0094,1043.428;Float;False;0;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.TimeNode;33;-1327.269,-285.2771;Float;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.AppendNode;41;-1210.469,-438.8768;Float;False;FLOAT4;0;0;0;0;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;FLOAT4
Node;AmplifyShaderEditor.PowerNode;70;-754.4542,1123.443;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SamplerNode;45;-1051.071,1252.358;Float;True;Property;_Emissivecities;Emissive (cities);8;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;119;-1424.926,-1274.193;Float;False;556.2625;499.6566;Albedo 1st pass;3;114;113;61;
Node;AmplifyShaderEditor.TextureCoordinatesNode;32;-1226.469,-566.8764;Float;False;0;-1;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-1045.669,-326.8771;Float;False;0;FLOAT4;0.0;False;1;FLOAT;0.0,0,0,0;False;FLOAT4
Node;AmplifyShaderEditor.ColorNode;47;-1005.903,1446.96;Float;False;Property;_Citiescolor;Cities color;9;0;1,0.815662,0.559,0;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WorldNormalVector;19;-895.3073,329.4849;Float;False;0;FLOAT3;0,0,0;False;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;12;-905.2074,553.1846;Float;False;Property;_Subatmospherepower;Sub atmosphere power;1;0;5;0;10;FLOAT
Node;AmplifyShaderEditor.ColorNode;114;-1294.459,-981.5358;Float;False;Property;_Albedocolor;Albedo color;4;0;1,1,1,0;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;61;-1374.926,-1224.193;Float;True;Property;_Albedo;Albedo;3;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;40;-887.2693,-392.477;Float;False;0;FLOAT2;0.0;False;1;FLOAT4;0.0,0;False;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;11;-926.2074,473.1848;Float;False;Property;_Subatmosphereglobalintensity;Sub atmosphere global intensity;2;0;1;0;5;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;123;-544.6234,-570.9338;Float;False;689.5588;543.2294;Clouds color + activation;4;26;107;67;105;
Node;AmplifyShaderEditor.ClampOpNode;72;-546.133,1183.544;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-735.5031,1309.161;Float;False;0;FLOAT4;0.0;False;1;COLOR;0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-321.4462,1261.576;Float;True;0;FLOAT;0.0,0,0,0;False;1;COLOR;0.0;False;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;-1037.664,-1109.934;Float;False;0;FLOAT4;0.0;False;1;COLOR;0.0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.CommentaryNode;120;-603.587,-1284.305;Float;False;1143.281;544.1838;Sunset ramp;6;93;95;98;94;97;91;
Node;AmplifyShaderEditor.ColorNode;107;-462.8132,-439.9326;Float;False;Constant;_Color0;Color 0;15;0;0,0,0,0;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;26;-502.1509,-247.1661;Float;True;Property;_CloudsAlpha;Clouds (Alpha);14;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;141;-128.0472,972.0952;Float;False;285;303.0001;Cities occluded by clouds;1;51;
Node;AmplifyShaderEditor.FresnelNode;9;-585.501,423.4186;Float;False;0;FLOAT3;0,0,0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;5.0;False;FLOAT
Node;AmplifyShaderEditor.ColorNode;15;-249.8627,454.6169;Float;False;Property;_Subatmospherecolor;Sub atmosphere color;0;0;1,1,1,0;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;129;768.8414,134.6662;Float;False;352.8645;166.9128;Clouds occlusion (Gloss and normal);1;81;
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;93;-553.587,-1234.305;Float;True;0;FLOAT;0.0;False;FLOAT3
Node;AmplifyShaderEditor.WorldNormalVector;95;-530.0147,-1004.709;Float;False;0;FLOAT3;0,0,0;False;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;133;-780.7077,-757.5706;Float;False;0;COLOR;0.0;False;COLOR
Node;AmplifyShaderEditor.CommentaryNode;127;385.7735,871.1949;Float;False;578.6374;316.59;Add ambiant;2;116;115;
Node;AmplifyShaderEditor.ToggleSwitchNode;105;-133.1977,-325.8942;Float;False;Property;_Desactivateclouds;Desactivate clouds;17;1;[Toggle];0;0;FLOAT;0.0;False;1;COLOR;0.0;False;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-256.051,225.1207;Float;True;0;FLOAT;0,0,0,0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-71.44732,1024.295;Float;True;0;FLOAT;0,0,0,0;False;1;COLOR;0.0;False;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;69;-43.74596,1307.933;Float;False;Property;_Citiesintensity;Cities intensity;10;0;0;0;5;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;126;1087.495,795.2741;Float;False;1126.196;490.5001;Specular map / gloss;6;83;112;80;110;78;82;
Node;AmplifyShaderEditor.CommentaryNode;138;318.9637,-437.2623;Float;False;725.9999;474.9703;Albedo 2nd pass;3;142;144;66;
Node;AmplifyShaderEditor.RangedFloatNode;98;-233.2328,-855.1212;Float;False;Constant;_Float1;Float 1;15;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.ColorNode;67;-168.4022,-510.3954;Float;False;Property;_cloudscolor;clouds color;15;0;0.4338235,0.4338235,0.4338235,0;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.DotProductOpNode;94;-255.9704,-1095.659;Float;False;0;FLOAT3;0.0;False;1;FLOAT3;0,0,0;False;FLOAT
Node;AmplifyShaderEditor.WireNode;134;95.28767,-651.5978;Float;False;0;COLOR;0.0;False;COLOR
Node;AmplifyShaderEditor.WireNode;137;614.8068,1197.986;Float;False;0;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;81;877.9109,189.4882;Float;False;0;COLOR;0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.CommentaryNode;125;1544.028,1344.588;Float;False;622.5995;715.5227;Normal map;5;90;101;87;85;88;
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;51.97255,343.7913;Float;True;0;FLOAT;0,0,0,0;False;1;COLOR;0.0;False;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;208.5539,927.0963;Float;False;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.ColorNode;116;442.0899,947.0967;Float;False;Property;_Ambiantcolor;Ambiant color;18;0;0,0,0,0;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;82;1137.495,1064.224;Float;True;Property;_watermask;water mask;11;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;66;364.4473,-372.2073;Float;True;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;144;456.9279,-117.5811;Float;False;Property;_Desaturation;Desaturation;5;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.AppendNode;97;-51.334,-1173.444;Float;True;FLOAT4;0;0;0;0;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;FLOAT4
Node;AmplifyShaderEditor.CommentaryNode;130;714.1016,447.2347;Float;False;204;183;Emissive 1st pass;1;76;
Node;AmplifyShaderEditor.WireNode;136;1095.292,1703.429;Float;False;0;COLOR;0.0;False;COLOR
Node;AmplifyShaderEditor.ClampOpNode;74;333.887,341.9655;Float;False;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;90;1594.027,1945.111;Float;False;Property;_Normalintensity;Normal intensity;7;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.WireNode;140;377.2528,786.0031;Float;False;0;COLOR;0.0;False;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;78;1253.091,859.7971;Float;False;Property;_Gloss;Gloss;12;0;0.81;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;110;1573.098,1105.878;Float;False;0;FLOAT;0.0;False;1;FLOAT4;0.0;False;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;115;789.0943,1051.735;Float;False;0;COLOR;0.0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.DesaturateOpNode;142;794.1277,-212.9811;Float;False;0;FLOAT3;0,0,0;False;1;FLOAT;0.0;False;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;91;218.694,-1010.264;Float;True;Property;_LookupSunset;Lookup Sunset;13;0;Assets/Exo planets/Textures/Lookup Sunset.tga;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;76;764.1016,497.2347;Float;False;0;COLOR;0.0,0,0,0;False;1;COLOR;0.0;False;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;1861.272,1779.418;Float;False;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.SamplerNode;85;1607.393,1394.588;Float;True;Property;_Normalmap;Normal map;6;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;131;1504.415,430.1609;Float;False;305.0802;291.3;Emissive 2nd pass;1;118;
Node;AmplifyShaderEditor.Vector3Node;87;1638.834,1599.094;Float;True;Constant;_Vector0;Vector 0;13;0;0,0,1;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;139;1046.457,743.8669;Float;False;0;COLOR;0.0;False;COLOR
Node;AmplifyShaderEditor.CommentaryNode;121;1822.603,-127.5519;Float;False;284.9999;303;Albedo 3rd pass;1;99;
Node;AmplifyShaderEditor.ClampOpNode;112;1713.667,1104.247;Float;False;0;FLOAT4;0.0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;1,1,1,1;False;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;80;1617.756,845.2739;Float;True;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;1907.803,-70.95192;Float;True;0;FLOAT4;0.0;False;1;FLOAT3;0,0,0,0;False;FLOAT4
Node;AmplifyShaderEditor.LerpOp;88;1982.627,1602.911;Float;False;0;FLOAT3;0.0;False;1;FLOAT3;0,0,0;False;2;COLOR;0.0;False;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;1917.941,1008.401;Float;False;0;COLOR;0,0,0,0;False;1;FLOAT4;0.0,0,0,0;False;FLOAT4
Node;AmplifyShaderEditor.SimpleAddOpNode;118;1550.805,480.1609;Float;True;0;COLOR;0.0,0,0,0;False;1;COLOR;0.0;False;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2320.319,412.4583;Float;False;True;2;Float;ASEMaterialInspector;Standard;Custom/Planet;False;False;False;False;True;False;True;True;True;True;False;False;Back;1;0;False;100000;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;DstColor;SrcColor;0;Zero;Zero;Add;Add;0;False;2.5;0,0,0,0;VertexOffset;False;Cylindrical;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;0.0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False
WireConnection;7;0;49;0
WireConnection;7;1;8;0
WireConnection;50;0;7;0
WireConnection;135;0;50;0
WireConnection;132;0;135;0
WireConnection;41;0;28;0
WireConnection;41;1;42;0
WireConnection;70;0;132;0
WireConnection;70;1;71;0
WireConnection;34;0;41;0
WireConnection;34;1;33;1
WireConnection;40;0;32;0
WireConnection;40;1;34;0
WireConnection;72;0;70;0
WireConnection;46;0;45;0
WireConnection;46;1;47;0
WireConnection;48;0;72;0
WireConnection;48;1;46;0
WireConnection;113;0;61;0
WireConnection;113;1;114;0
WireConnection;26;1;40;0
WireConnection;9;0;19;0
WireConnection;9;2;11;0
WireConnection;9;3;12;0
WireConnection;133;0;113;0
WireConnection;105;0;26;4
WireConnection;105;1;107;0
WireConnection;22;0;7;0
WireConnection;22;1;9;0
WireConnection;51;0;26;4
WireConnection;51;1;48;0
WireConnection;94;0;93;0
WireConnection;94;1;95;0
WireConnection;134;0;133;0
WireConnection;137;0;72;0
WireConnection;81;0;105;0
WireConnection;13;0;22;0
WireConnection;13;1;15;0
WireConnection;68;0;51;0
WireConnection;68;1;69;0
WireConnection;66;0;134;0
WireConnection;66;1;67;0
WireConnection;66;2;105;0
WireConnection;97;0;94;0
WireConnection;97;1;98;0
WireConnection;136;0;81;0
WireConnection;74;0;13;0
WireConnection;140;0;68;0
WireConnection;110;0;82;4
WireConnection;110;1;82;0
WireConnection;115;0;116;0
WireConnection;115;1;137;0
WireConnection;142;0;66;0
WireConnection;142;1;144;0
WireConnection;91;1;97;0
WireConnection;76;0;74;0
WireConnection;76;1;140;0
WireConnection;101;0;136;0
WireConnection;101;1;90;0
WireConnection;139;0;115;0
WireConnection;112;0;110;0
WireConnection;80;0;81;0
WireConnection;80;1;78;0
WireConnection;99;0;91;0
WireConnection;99;1;142;0
WireConnection;88;0;87;0
WireConnection;88;1;85;0
WireConnection;88;2;101;0
WireConnection;83;0;80;0
WireConnection;83;1;112;0
WireConnection;118;0;76;0
WireConnection;118;1;139;0
WireConnection;0;0;99;0
WireConnection;0;1;88;0
WireConnection;0;2;118;0
WireConnection;0;4;83;0
ASEEND*/
//CHKSM=A6D575D1983056D4715E83B306B167318D87A369