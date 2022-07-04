Class {
	#name : #PTFakeClass3,
	#superclass : #Object,
	#instVars : [
		'scale'
	],
	#category : #'Tool-Tracer-Tests-Helpers'
}

{ #category : #enumerating }
PTFakeClass3 >> do: aBlock [

	^ aBlock value * scale
]

{ #category : #enumerating }
PTFakeClass3 >> example [

	| tmp |
	tmp := 10.
	scale := 3 * tmp.
	^ self do: [ PTFakeClass2 new run ]
]
