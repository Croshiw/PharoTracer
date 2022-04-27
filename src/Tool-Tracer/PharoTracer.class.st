"
Tracing things in Pharo
"
Class {
	#name : #PharoTracer,
	#superclass : #Object,
	#instVars : [
		'executableCode',
		'classesToObserve',
		'records'
	],
	#category : #'Tool-Tracer'
}

{ #category : #accessing }
PharoTracer >> classesToObserve [

	^ classesToObserve
]

{ #category : #accessing }
PharoTracer >> classesToObserve: anObject [

	classesToObserve := anObject
]

{ #category : #accessing }
PharoTracer >> executableCode [

	^ executableCode
]

{ #category : #accessing }
PharoTracer >> executableCode: anObject [

	executableCode := anObject
]

{ #category : #initialization }
PharoTracer >> initialize [

	records := OrderedCollection new
]

{ #category : #accessing }
PharoTracer >> records [

	^ records
]

{ #category : #accessing }
PharoTracer >> records: anObject [

	records := anObject
]

{ #category : #'api - running' }
PharoTracer >> run [


	^ records
]
