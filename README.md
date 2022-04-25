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
Here, we want the name of the method and the arguments it takes"
link := MetaLink new.
link metaObject: [ :selector :args| selector trace. ' ' trace. args traceCr ].
link selector: #value:value:.
link arguments: #(selector arguments).
link control: #before.

"We install the metalink on every method of every class that is in the package that contains our observed Class --> SMFakeClass3" 
((SMFakeClass3 package classes collect: #methods) flattened collect: #ast) do:[:node|
	 node link: link].

"You need to execute your code to get something in the Transcript"
SMFakeClass3 new example.

"Another example of a Metalink.
Here, we want to get the name of every variable and its value when its changed or initialized"
link2 := MetaLink new.
link2 metaObject: [ :name :value| name  traceCr. ': ' trace. value traceCr ].
link2 selector: #value:value:.
link2 arguments: #(name value).
link2 control: #before.

"We install the metalink on all the slots/variables in the every class that is in the package that contains our observed Class --> SMFakeClass3"
(SMFakeClass3 package classes collect: #allSlots) flattened do:[:slot| 
    slot owningClass link: link2 toSlot: slot].

"Execute this or link uninstall to remove all metalinks"
MetaLink uninstallAll 
```
