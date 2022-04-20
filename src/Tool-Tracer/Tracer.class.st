Class {
	#name : #Tracer,
	#superclass : #SpPresenter,
	#instVars : [
		'reposPanel',
		'codePanel',
		'installMetalinkButton',
		'runTracerButton'
	],
	#category : #'Tool-Tracer'
}

{ #category : #'instance creation' }
Tracer class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: #reposPanel;
				   add: #codePanel;
				   yourself);
		  "add: (SpBoxLayout newLeftToRight
				   add: #installMetalinkButton;
				   add: #runTracerButton;
				   yourself);"
				add: #runTracerButton
		  withConstraints: [ :constraints | 
		  constraints height: self toolbarHeight ];
		  yourself
]

{ #category : #'instance creation' }
Tracer class >> open [
	<script>
	self new open
]

{ #category : #'instance creation' }
Tracer class >> title [

	^ 'Tracing Browser'
]

{ #category : #initialization }
Tracer >> initializeRepositoryList [

	reposPanel items: self packagesAvailableForTracing;
	display: [ :package | package name ]
]

{ #category : #initialization }
Tracer >> initializeWidgets [

	codePanel := self newCode.
	installMetalinkButton := self newButton.
	runTracerButton := self newButton.
	reposPanel := self newFilteringList.
	self initializeRepositoryList.
	installMetalinkButton label: 'Install Metalink'.
	runTracerButton label: 'Run Tracer Code'
]

{ #category : #initialization }
Tracer >> packagesAvailableForTracing [

	"I have to find a way to only select the packages that are in iceberg"

	^ RPackage organizer packages select: [ :p | 
		  p definedClasses anySatisfy: [ :c | c isTestCase not ] ]
]
