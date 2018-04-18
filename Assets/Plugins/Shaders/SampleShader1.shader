﻿Shader "Custom/SampleShader1" {
	Properties {
		_MainTex("Main Tex", 2D) = "white" {}
	}
    SubShader {
		Tags { "RenderType" = "Opaque" }
		CGPROGRAM
		#pragma surface surf Lambert //alpha
		struct Input {
			float2 uv_MainTex;
			//float4 color : COLOR;
		};
		//float4 _ColorX;
		sampler2D _MainTex;
		float3 yuv2rgb(float3 yuv) {
			// The YUV to RBA conversion, please refer to: http://en.wikipedia.org/wiki/YUV
            // Y'UV420sp (NV21) to RGB conversion (Android) section.
			float y_value = yuv[0];
			float u_value = yuv[1];
			float v_value = yuv[2];
            float r = y_value + 1.370705 * (v_value - 0.5);
            float g = y_value - 0.698001 * (v_value - 0.5) - (0.337633 * (u_value - 0.5));
            float b = y_value + 1.732446 * (u_value - 0.5);
			return float3(r, g, b);
		}
		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = yuv2rgb(tex2D(_MainTex, IN.uv_MainTex).rgb);
		}
		ENDCG
    }
	Fallback "Diffuse"

/*	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
	*/
}