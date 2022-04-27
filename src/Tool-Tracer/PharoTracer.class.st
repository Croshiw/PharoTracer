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
		'link'
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
		run1
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
PharoTracer >> initializeMetalink [

link := MetaLink new.
	link metaObject: [ :selector :args | 
		selector trace.
		' ' trace.
		args traceCr ].
	link selector: #value:value:.
	link arguments: #( selector arguments ).
	link control: #before
]

{ #category : #'api - running' }
PharoTracer >> installMetalink [

	((classesToObserve collect: #methods) flattened collect: #ast) do: [ 
		:node | node link: link ]
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

	self initializeMetalink.
	self installMetalink.
	self executableCode value.
	self uninstallMetalink
]

{ #category : #'api - running' }
PharoTracer >> run1 [

	self initializeMetalink.
	self installMetalink.
	self executableCode value.
	self uninstallMetalink
]

{ #category : #'api - running' }
PharoTracer >> uninstallMetalink [

	MetaLink uninstallAll
]
