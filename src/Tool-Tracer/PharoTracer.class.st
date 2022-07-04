"
Tracing things in Pharo.
I use Metalink to get the information I need.
The idea is to install 4 Metalinks:
- One to get the info about the method I'm in with its arguments, 
- One to get the info about the value change of a variable
- One to get the info about what is returned in a method
- One to get what exception has been called

Then I install the metalinks in the desired nodes

Run this in the playground for an example
```language=Pharo
example
   PharoTracer new
		classesToObserve: { 
				PTFakeClass1.
				PTFakeClass2.
				PTFakeClass3 };
		executableCode: [ PTFakeClass3 new example ];
		run;records
```
"
Class {
	#name : #PharoTracer,
	#superclass : #Object,
	#instVars : [
		'executableCode',
		'classesToObserve',
		'records',
		'methodsLink',
		'variablesLink',
		'returnsLink'
	],
	#category : #'Tool-Tracer-Core'
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

{ #category : #'api - running' }
PharoTracer >> initializeMethodsMetalink [

	methodsLink := MetaLink new.
	methodsLink metaObject: [ :method :args | 
		records add: (PTMethodCallLogRecord new
				 associatedClass: method methodClass;
				 associatedMethod: method;
				 associatedArguments: args) ].
	methodsLink selector: #value:value:.
	methodsLink arguments: #( method arguments ).
	methodsLink control: #before
]

{ #category : #'api - running' }
PharoTracer >> initializeReturnsMetalink [

	returnsLink := MetaLink new.
	returnsLink metaObject: [ :method :value | 
		records add: (PTReturnLogRecord new
				 associatedClass: method methodClass;
				 associatedMethod: method;
				 returnedValue: value) ].
	returnsLink selector: #value:value:.
	returnsLink arguments: #( method value ).
	returnsLink control: #before
]

{ #category : #'api - running' }
PharoTracer >> initializeVariablesMetalink [

	variablesLink := MetaLink new.
	variablesLink metaObject: [ :method :name :value :nv | 
		records add: (PTVariableLogRecord new
				 associatedClass: method methodClass;
				 associatedMethod: method;
				 variableName: name;
				 oldValue: value;
				 newValue: nv) ].
	variablesLink selector: #value:value:value:value:.
	variablesLink arguments: #( method name value newValue ).
	variablesLink control: #before
]

{ #category : #'api - running' }
PharoTracer >> installMetalink [

	((classesToObserve collect: #methods) flattened collect: #ast) do: [ 
		:node | node link: methodsLink ].

	((classesToObserve collect: #methods) flattened collect:
		 #variableWriteNodes) flattened do: [ :node | 
		node link: variablesLink ].

	((classesToObserve collect: #methods) flattened collect: #returnNodes)
		flattened do: [ :node | 
		node link: returnsLink  ].
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
	self initializeReturnsMetalink.
	self installMetalink.
	self executableCode value.
	self uninstallMetalink
]

{ #category : #'api - running' }
PharoTracer >> uninstallMetalink [

	MetaLink uninstallAll
]
