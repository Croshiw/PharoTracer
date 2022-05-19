Class {
	#name : #PTMethodCallLogRecord,
	#superclass : #PTAbstractLogRecord,
	#instVars : [
		'associatedArguments'
	],
	#category : #'Tool-Tracer-Model'
}

{ #category : #accessing }
PTMethodCallLogRecord >> associatedArguments [

	^ associatedArguments
]

{ #category : #accessing }
PTMethodCallLogRecord >> associatedArguments: anObject [

	associatedArguments := anObject
]
