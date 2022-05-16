"
Tracing things in Pharo
"
Class {
	#name : #PharoTracer,
	#superclass : #Object,
	#instVars : [
		'executableCode',
		'classesToObserve',
		'records',
		'methodsLink',
		'variablesLink'
	],
	#category : #'Tool-Tracer-Core'
}

{ #category : #examples }
PharoTracer class >> example [

	"Open Transcript to see result"

	self new
		classesToObserve: { 
				SMFakeClass1.
				SMFakeClass2.
				SMFakeClass3 };
		executableCode: [ SMFakeClass3 new example ];
		run
]

{ #category : #examples }
PharoTracer class >> exampleSmallTrace [

	"Open Transcript to see result"

	self new
		classesToObserve: { 
				SMFakeClass1. };
		executableCode: [ SMFakeClass1 new sum: 7 ];
		run
]

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

{ #category : #'api - running' }
PharoTracer >> initializeMethodsMetalink [

	methodsLink := MetaLink new.
	methodsLink metaObject: [ :context :args | 
		"context trace.
		' ' trace.
		args traceCr"
		records add: (PharoMethodLogRecord new context: context; arguments: args) ].
	methodsLink selector: #value:value:.
	methodsLink arguments: #( context arguments ).
	methodsLink control: #before
]

{ #category : #'api - running' }
PharoTracer >> initializeVariablesMetalink [

	variablesLink := MetaLink new.
	variablesLink metaObject: [ :context :name :value :nv |
		"context trace.
		' --> ' trace.
		name trace.
		' : ' trace.
		value trace.
		' --> ' trace.
		nv traceCr" 
		records add: (PharoVariableLogRecord new context: context;variableName: name;oldValue: value; newValue: nv)].
	variablesLink selector: #value:value:value:value:.
	variablesLink arguments: #( context name value newValue ).
	variablesLink control: #before
]

{ #category : #'api - running' }
PharoTracer >> installMetalink [

	((classesToObserve collect: #methods) flattened collect: #ast) do: [ 
		:node | node link: methodsLink ].
	
((classesToObserve  collect: #methods) flattened collect: #variableWriteNodes) flattened do:[:node| 
	 	node link: variablesLink ].
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

	self initializeMethodsMetalink.
	self initializeVariablesMetalink. 
	self installMetalink.
	self executableCode value.
	self uninstallMetalink
]

{ #category : #'api - running' }
PharoTracer >> uninstallMetalink [

	MetaLink uninstallAll
]
