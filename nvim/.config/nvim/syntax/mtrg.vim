" Vim syntax file
" Language: mtstudio rendergraph format

if exists("b:current_syntax")
	finish
endif

syn keyword Keyword Include DescriptorSet Buffer Image Pipeline RenderPass Asset VertexAttribute Shader AccelerationStructure
syn region Comment start='#' end='\n'
syn keyword Type r8u r8 rg8 rgba8 r16u r16 rgba16 r32 d32 rg32 rg16 rgb32 rgba32 r32i r32u
