shader_type canvas_item;

uniform sampler2D breasts_tex : hint_albedo;

uniform vec2 uv_center = vec2(0.5, 0.75);
uniform vec2 breast_offset = vec2(0.5, 0.0);
uniform vec2 spring_offset = vec2(0.0,0.0);
uniform float influence_start = 0.0;
uniform float influence_blend = 0.6;
uniform float pull_strength = 1.5;
uniform bool debug = false;

void vertex() {
    vec2 uv = VERTEX / vec2(563.0, 289.0);

    float d = distance(uv_center + breast_offset, uv);
    float influence = 1.0 - smoothstep(influence_start, influence_start + influence_blend, d);
    d = distance(uv_center - vec2(breast_offset.x, -breast_offset.y), uv);
    influence += 1.0 - smoothstep(influence_start, influence_start + influence_blend, d);
    
    VERTEX.xy += (influence * spring_offset * pull_strength);
}

void fragment() {
    vec4 color = texture(breasts_tex, UV);
    COLOR = color;
    
    float d = distance(uv_center + breast_offset, UV);
    float influence = 1.0 - smoothstep(influence_start, influence_start + influence_blend, d);
    d = distance(uv_center - vec2(breast_offset.x, -breast_offset.y), UV);
    influence += 1.0 - smoothstep(influence_start, influence_start + influence_blend, d);
    
    if (debug) {
        COLOR = vec4(vec3(influence), 1.0);
    }
}