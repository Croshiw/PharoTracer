# PharoTracer

Tracing code in Pharo

## How to install it?

To install PharoTracer, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'ToolTracer';
  repository: 'github://Croshiw/PharoTracer/src';
  load.
```

## Small exemple of how to use metalinks

```Smalltalk
"How to get the AST of a method"
ast := (SMFakeClass3 lookupSelector: #example) ast.

"A first example of a Metalink.
Here, we want the class, the name of the method and the arguments it takes"
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

"We install the metalink on every method of a collection of classes we give" 
(({SMFakeClass1.SMFakeClass2.SMFakeClass3} collect: #methods) flattened collect: #ast) do: [ 
		:node | node link: methodsLink ].

"Another example of a Metalink.
Here, we want to get the name of every variable and its value before and after"
variablesLink := MetaLink new.
variablesLink metaObject: [ :name :value :nv | 
		name trace.
		' : ' trace.
		value trace.
		' --> ' trace.
		nv traceCr ].
variablesLink selector: #value:value:value:.
variablesLink arguments: #( name value newValue ).
variablesLink control: #before.
"We install the metalink on all the variable nodes in a collection of classes"
(({SMFakeClass1.SMFakeClass2.SMFakeClass3} collect: #methods) flattened collect: #variableWriteNodes) flattened do: [ :node |
		node link: variablesLink ].

"You need to execute your code to get something in the Transcript"
SMFakeClass3 new example.

MetaLink uninstallAll.
```
