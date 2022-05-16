Class {
	#name : #PharoVariableLogRecord,
	#superclass : #PharoAbstractLogRecord,
	#instVars : [
		'variableName',
		'oldValue',
		'newValue'
	],
	#category : #'Tool-Tracer-Model'
}

{ #category : #accessing }
PharoVariableLogRecord >> newValue [

	^ newValue
]

{ #category : #accessing }
PharoVariableLogRecord >> newValue: anObject [

	newValue := anObject
]

{ #category : #accessing }
PharoVariableLogRecord >> oldValue [

	^ oldValue
]

{ #category : #accessing }
PharoVariableLogRecord >> oldValue: anObject [

	oldValue := anObject
]

{ #category : #accessing }
PharoVariableLogRecord >> variableName [

	^ variableName
]

{ #category : #accessing }
PharoVariableLogRecord >> variableName: anObject [

	variableName := anObject
]
