// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/Second atmosphere"
{
	Properties
	{
		_MaskClipValue( "Mask Clip Value", Float ) = 0.5
		[HideInInspector] __dirty( "", Int ) = 1
		_Secondatmospherecolor("Second atmosphere color", Color) = (0.5661765,0.8743408,1,0)
		_secondatmospherepower("second atmosphere power", Range( 0 , 5)) = 0
		_Secondatmosphereintensity("Second atmosphere intensity", Range( 0 , 10)) = 0
	}

	SubShader
	{
		Tags{ "RenderType" = "Overlay"  "Queue" = "Overlay+0" "IsEmissive" = "true"  }
		Cull Back
		Blend One One
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float2 texcoord_0;
		};

		uniform float4 _Secondatmospherecolor;
		uniform float _secondatmospherepower;
		uniform float _Secondatmosphereintensity;
		uniform float _MaskClipValue = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.texcoord_0.xy = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Emission = ( _Secondatmospherecolor * ( pow( i.texcoord_0.x , _secondatmospherepower ) * _Secondatmosphereintensity ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=6001
2567;29;1666;974;951.1;484.8;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;9;-646.1,84.20001;Float;False;Property;_secondatmospherepower;second atmosphere power;1;0;0;0;5;FLOAT
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-692.1,-67.79999;Float;False;0;-1;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.PowerNode;7;-354.1,-44.79999;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;11;-296.1,135.2;Float;False;Property;_Secondatmosphereintensity;Second atmosphere intensity;2;0;0;0;10;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-145.1,-23.79999;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.ColorNode;5;-663.1,-275.8;Float;False;Property;_Secondatmospherecolor;Second atmosphere color;1;0;0.5661765,0.8743408,1,0;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-8.099976,-128.8;Float;False;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;156,-52;Float;False;True;2;Float;ASEMaterialInspector;Standard;Custom/Second atmosphere;False;False;False;False;True;True;True;True;True;True;True;True;Back;0;0;False;0;0;Custom;0.5;True;True;0;False;Overlay;Overlay;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;4;One;One;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;0.0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False
WireConnection;7;0;6;1
WireConnection;7;1;9;0
WireConnection;10;0;7;0
WireConnection;10;1;11;0
WireConnection;4;0;5;0
WireConnection;4;1;10;0
WireConnection;0;2;4;0
ASEEND*/
//CHKSM=998C2034375C8CBF4A98694FFA7D3E89E3E939F6