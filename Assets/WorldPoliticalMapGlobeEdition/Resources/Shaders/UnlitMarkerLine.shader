Shader "World Political Map/Unlit Marker Line" {
 
Properties {
    _Color ("Color", Color) = (1,1,1,0.5)
    _MainTex("Texture (RGBA)", 2D) = "white" {}
}
 
SubShader {
         Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}

	     Cull Off
         ZWrite Off
         Blend SrcAlpha OneMinusSrcAlpha 
         ColorMask RGB

       Pass {
        CGPROGRAM
        #pragma vertex vert 
        #pragma fragment frag
        #pragma fragmentoption ARB_precision_hint_fastest
        #include "UnityCG.cginc"

        sampler2D _MainTex;
        fixed4 _Color;

        struct appdata {
            float4 vertex : POSITION;
            float2 texcoord: TEXCOORD0;
                    UNITY_VERTEX_INPUT_INSTANCE_ID
        };

        struct v2f {
            float4 pos : SV_POSITION;
            float2 uv: TEXCOORD0;
            UNITY_VERTEX_INPUT_INSTANCE_ID
            UNITY_VERTEX_OUTPUT_STEREO
        };
        
        v2f vert(appdata v) {
            v2f o;
            UNITY_SETUP_INSTANCE_ID(v);
            UNITY_INITIALIZE_OUTPUT(v2f, o);
            UNITY_TRANSFER_INSTANCE_ID(v, o);
            UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
            o.pos = UnityObjectToClipPos(v.vertex);
            o.uv = v.texcoord;
            return o;
        }
        
        fixed4 frag(v2f i) : SV_Target {
                    UNITY_SETUP_INSTANCE_ID(i);
                    UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i); 
            fixed4 p = tex2D(_MainTex, i.uv);
            return p * _Color;                  
        }
            
        ENDCG
    }
 }

}
 
