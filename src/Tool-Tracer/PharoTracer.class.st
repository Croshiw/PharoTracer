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
	#category : #'Tool-Tracer'
}

{ #category : #examples }
PharoTracer class >> example1 [

	"Open Transcript to see result"

	self new
		classesToObserve: { 
				SMFakeClass1.
				SMFakeClass2.
				SMFakeClass3 };
		executableCode: [ SMFakeClass3 new example ];
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
	methodsLink metaObject: [ :receiver :selector :args | 
		receiver trace.
		' ' trace.
		selector trace.
		' ' trace.
		args traceCr ].
	methodsLink selector: #value:value:value:.
	"i can just use context instead of receiver and selector"
	methodsLink arguments: #( receiver selector arguments ).
	methodsLink control: #before.

]

{ #category : #'api - running' }
PharoTracer >> initializeVariablesMetalink [


	variablesLink := MetaLink new.
	variablesLink metaObject: [ :name :value :nv | 
		name trace.
		' : ' trace.
		value trace.
		' --> ' trace.
		nv traceCr ].
	variablesLink selector: #value:value:value:.
	variablesLink arguments: #( name value newValue ).
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
