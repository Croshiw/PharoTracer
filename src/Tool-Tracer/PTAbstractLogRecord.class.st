"
I represent the abstract model of all the logs. I should know the class and the method I am associated with.
"
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
