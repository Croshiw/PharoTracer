Class {
	#name : #PTReturnLogRecord,
	#superclass : #PTAbstractLogRecord,
	#instVars : [
		'returnedValue'
	],
	#category : #'Tool-Tracer-Model'
}

{ #category : #accessing }
PTReturnLogRecord >> returnedValue [

	^ returnedValue
]

{ #category : #accessing }
PTReturnLogRecord >> returnedValue: anObject [

	returnedValue := anObject
]
