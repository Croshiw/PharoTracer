Class {
	#name : #PTFakeClass1,
	#superclass : #Object,
	#instVars : [
		'balance'
	],
	#category : #'Tool-Tracer-Tests-Helpers'
}

{ #category : #accessing }
PTFakeClass1 >> balance [

	^ balance
]

{ #category : #'math functions' }
PTFakeClass1 >> increment [

	balance := balance + 1
]

{ #category : #initialization }
PTFakeClass1 >> initialize [

	balance := 0
]

{ #category : #'math functions' }
PTFakeClass1 >> sum: anInt [

	balance := balance + anInt.
	self increment
]
