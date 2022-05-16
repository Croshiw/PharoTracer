Class {
	#name : #PharoMethodLogRecord,
	#superclass : #PharoAbstractLogRecord,
	#instVars : [
		'arguments'
	],
	#category : #'Tool-Tracer-Model'
}

{ #category : #accessing }
PharoMethodLogRecord >> arguments [

	^ arguments
]

{ #category : #accessing }
PharoMethodLogRecord >> arguments: anObject [

	arguments := anObject
]
