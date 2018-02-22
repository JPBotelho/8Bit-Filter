Shader "Filters/8Bit"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}

		_Bit("Bit Level", Range(1, 20)) = 8
		
	}	
	SubShader
	{
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;

			int _Bit;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				float4 sample = tex2D(_MainTex, i.uv);

				return float4(round(sample.rgb * _Bit) / _Bit, 1);
			}		    
			ENDCG
		}
	}
}