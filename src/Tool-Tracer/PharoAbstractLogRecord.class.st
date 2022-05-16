Class {
	#name : #PharoAbstractLogRecord,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'Tool-Tracer-Model'
}

{ #category : #accessing }
PharoAbstractLogRecord >> context [

	^ context
]

{ #category : #accessing }
PharoAbstractLogRecord >> context: anObject [

	context := anObject
]
