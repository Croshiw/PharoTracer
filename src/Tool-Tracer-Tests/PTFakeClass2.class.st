Class {
	#name : #PTFakeClass2,
	#superclass : #Object,
	#category : #'Tool-Tracer-Tests-Helpers'
}

{ #category : #running }
PTFakeClass2 >> addHundred: aFake1 [

	^ aFake1
		  sum: 100;
		  yourself
]

{ #category : #running }
PTFakeClass2 >> getFake1 [

	^ PTFakeClass1 new
]

{ #category : #running }
PTFakeClass2 >> run [

	| v1 v2 |
	v1 := self getFake1 sum: 50.
	v2 := self getFake1 sum: 60.
	^ v1 balance + v2 balance
]
