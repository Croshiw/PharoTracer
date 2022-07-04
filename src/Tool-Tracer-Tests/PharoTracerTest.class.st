"
A PharoTracerTest is a test class for testing the behavior of PharoTracer
"
Class {
	#name : #PharoTracerTest,
	#superclass : #TestCase,
	#category : #'Tool-Tracer-Tests-Core'
}

{ #category : #test }
PharoTracerTest >> testTrace1 [

	| obs |
	obs := PharoTracer new
		       classesToObserve: { PTFakeClass1 };
		       executableCode: [ 
			       PTFakeClass1 new
				       sum: 100;
				       sum: 10 ].
	obs run.
	self assert: obs records size equals: 10.
	self assert: obs records first class equals: PTMethodCallLogRecord.
	self assert: obs records second class equals: PTVariableLogRecord 
]

{ #category : #test }
PharoTracerTest >> testTrace2 [

	| obs rec |
	obs := PharoTracer new
		       classesToObserve: { 
				       PTFakeClass1.
				       PTFakeClass2.
				       PTFakeClass3 };
		       executableCode: [ PTFakeClass3 new example ].
	obs run.
	rec := obs records at: 1.
	self assert: rec associatedClass equals: PTFakeClass3.
	"self assert: rec associatedMethod equals: PTFakeClass3 >> #example."
	self assertCollection: rec associatedArguments hasSameElements: #(  )
]
