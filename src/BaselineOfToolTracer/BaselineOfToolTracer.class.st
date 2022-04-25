"
For now since I'm using SmallMince proxies so the Tool Tracer depends on small mince project
"
Class {
	#name : #BaselineOfToolTracer,
	#superclass : #BaselineOf,
	#category : #BaselineOfToolTracer
}

{ #category : #baselines }
BaselineOfToolTracer >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		"External dependencies"
		spec
			baseline: 'SmallMince'
			with: [ spec repository: 'github://mabdi/small-mince' ].
		
		"Packages"
		spec package: 'Tool-Tracer' with: [ spec requires: #('SmallMince') ] 
		
	]
]
