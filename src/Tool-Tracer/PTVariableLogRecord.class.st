Class {
	#name : #PTVariableLogRecord,
	#superclass : #PTAbstractLogRecord,
	#instVars : [
		'variableName',
		'oldValue',
		'newValue'
	],
	#category : #'Tool-Tracer-Model'
}

{ #category : #accessing }
PTVariableLogRecord >> newValue [

	^ newValue
]

{ #category : #accessing }
PTVariableLogRecord >> newValue: anObject [

	newValue := anObject
]

{ #category : #accessing }
PTVariableLogRecord >> oldValue [

	^ oldValue
]

{ #category : #accessing }
PTVariableLogRecord >> oldValue: anObject [

	oldValue := anObject
]

{ #category : #accessing }
PTVariableLogRecord >> variableName [

	^ variableName
]

{ #category : #accessing }
PTVariableLogRecord >> variableName: anObject [

	variableName := anObject
]
