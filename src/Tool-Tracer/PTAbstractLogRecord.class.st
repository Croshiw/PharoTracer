Class {
	#name : #PTAbstractLogRecord,
	#superclass : #Object,
	#instVars : [
		'associatedClass',
		'associatedMethod'
	],
	#category : #'Tool-Tracer-Model'
}

{ #category : #accessing }
PTAbstractLogRecord >> associatedClass [

	^ associatedClass
]

{ #category : #accessing }
PTAbstractLogRecord >> associatedClass: anObject [

	associatedClass := anObject
]

{ #category : #accessing }
PTAbstractLogRecord >> associatedMethod [

	^ associatedMethod
]

{ #category : #accessing }
PTAbstractLogRecord >> associatedMethod: anObject [

	associatedMethod := anObject
]
