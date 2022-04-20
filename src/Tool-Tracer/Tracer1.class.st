Class {
	#name : #Tracer1,
	#superclass : #Model,
	#instVars : [
		'classes',
		'classIndex',
		'classesSelected',
		'lastUpdate',
		'result',
		'previousRun',
		'classPattern',
		'testAnnouncementBlock',
		'packages',
		'packagesSelected',
		'packagePattern',
		'packageIndex'
	],
	#category : #'Tool-Tracer'
}

{ #category : #'instance creation' }
Tracer1 class >> open [

	<script>
	^ self new open
]

{ #category : #'instance creation' }
Tracer1 >> baseClass [
self flag: #change.
	^ TestCase
]

{ #category : #'instance creation' }
Tracer1 >> build [

	"self new build openInWorld"

	| window |
	window := (SystemWindow labelled: self label)
		          model: self;
		          extent: self extent.

	window
		addMorph: self buildPackageSearch
		fullFrame: self packageSearchFrame.
	window addMorph: self buildPackages fullFrame: self packagesFrame.

	window
		addMorph: self buildClassesSearch
		fullFrame: self classesSearchFrame.
	window addMorph: self buildClasses fullFrame: self classesFrame.
	
	window addMorph: self buildCodeFrame fullFrame: self codeFrame.
	window addMorph: self buildButtons fullFrame: self buttonsFrame.

	^ window
]

{ #category : #'instance creation' }
Tracer1 >> buildButtons [

	^ PanelMorph new
		  changeTableLayout;
		  listDirection: #leftToRight;
		  layoutInset: 0;
		  color: Color transparent;
		  addAllMorphs: (self buttons collect: [ :each | 
					   PluggableButtonMorph new
						   on: self
						   getState: nil
						   action: each second
						   label: nil
						   menu: nil;
						   label: each first;
						   setBalloonText: each third;
						   getEnabledSelector: (each at: 4);
						   hResizing: #spaceFill;
						   yourself ]);
		  yourself
]

{ #category : #'instance creation' }
Tracer1 >> buildClasses [

	^ PluggableListMorph new
		  on: self
		  list: #classList
		  primarySelection: #classSelected
		  changePrimarySelection: #classSelected:
		  listSelection: #classAt:
		  changeListSelection: #classAt:put:
		  menu: #classMenu:
		  keystroke: nil;
		  yourself
]

{ #category : #'instance creation' }
Tracer1 >> buildClassesSearch [

	^ SearchMorph new
		  model: self;
		  updateSelector: #classSearchUpdate:;
		  ghostText: 'ClassObserved #1 | ClassObserved #2';
		  yourself
]

{ #category : #'instance creation' }
Tracer1 >> buildCodeFrame [

	^ PluggableListMorph new
		  model: self;
		  yourself
]

{ #category : #'instance creation' }
Tracer1 >> buildPackageSearch [

	^ SearchMorph new
		  ghostText: 'Package #1 | Package #2';
		  model: self;
		  updateSelector: #packageSearchUpdate:;
		  yourself
]

{ #category : #'instance creation' }
Tracer1 >> buildPackages [

	^ PluggableListMorph new
		  on: self
		  list: #packageList
		  primarySelection: #packageSelected
		  changePrimarySelection: #packageSelected:
		  listSelection: #packageAt:
		  changeListSelection: #packageAt:put:
		  menu: #packageMenu:
		  keystroke: nil;
		  yourself
]

{ #category : #'instance creation' }
Tracer1 >> buttonHeight [

	^ self theme buttonMinHeight + 4
]

{ #category : #'instance creation' }
Tracer1 >> buttons [

	^ #( #( 'Trace Selected' #runAll 'Trace all selected tests'
	        #hasRunnable )
	     )
]

{ #category : #'instance creation' }
Tracer1 >> buttonsFrame [

	^ LayoutFrame new topFraction: 1 offset: self buttonHeight negated
]

{ #category : #'instance creation' }
Tracer1 >> classAt: anInteger [

	^ classesSelected includes:
		  (classes at: anInteger ifAbsent: [ ^ false ])
]

{ #category : #'instance creation' }
Tracer1 >> classAt: anInteger put: aBoolean [

	classesSelected := classesSelected
		                   perform: (aBoolean
				                    ifTrue: [ #copyWith: ]
				                    ifFalse: [ #copyWithout: ])
		                   with:
		                   (classes at: anInteger ifAbsent: [ ^ self ]).
	self
		changed: #classSelected;
		changed: #hasRunnable
]

{ #category : #'instance creation' }
Tracer1 >> classList [

	| offset |
	classes isEmpty ifTrue: [ ^ classes ].
	offset := classes first allSuperclasses size.
	^ classes collect: [ :each | 
		  | ident |
		  ident := String
			           new: 2 * (0 max: each allSuperclasses size - offset)
			           withAll: $ .
		  each isAbstract
			  ifFalse: [ ident , each name ]
			  ifTrue: [ 
				  (ident asText , each name asText)
					  addAttribute: TextEmphasis italic;
					  yourself ] ]
]

{ #category : #'instance creation' }
Tracer1 >> classMenu: aMenu [

	^ aMenu
		  addTitle: 'Classes';
		  add: 'Browse' selector: #browseClass;
		  addLine;
		  add: 'Select all' selector: #selectAllClasses;
		  add: 'Select unit tests' selector: #selectAllUnitTests;
		  add: 'Select subclasses' selector: #selectSubclasses;
		  add: 'Select inversion' selector: #selectInverseClasses;
		  add: 'Select none' selector: #selectNoClasses;
		  add: 'Refresh' selector: #updateClasses;
		  addLine;
		  add: 'Filter...' selector: #filterClasses;
		  addLine;
		  add: 'Run selected' selector: #runAll;
		  yourself
]

{ #category : #'instance creation' }
Tracer1 >> classSelected [

	^ classIndex
]

{ #category : #'instance creation' }
Tracer1 >> classesFrame [

	^ LayoutFrame new
		  leftFraction: 0.25;
		  topOffset: self theme textFont height + 13;
		  rightFraction: 0.5;
		  bottomOffset: self buttonHeight negated
]

{ #category : #'instance creation' }
Tracer1 >> classesSearchFrame [

	^ LayoutFrame new
		  leftFraction: 0.25;
		  rightFraction: 0.5;
		  bottomFraction: 0;
		  bottomOffset: StandardFonts defaultFont height + 6
]

{ #category : #'instance creation' }
Tracer1 >> codeFrame [

	^ LayoutFrame new
		  leftFraction: 0.5;
		  bottomFraction: 0.5;
		  bottomOffset: self buttonHeight negated
]

{ #category : #'instance creation' }
Tracer1 >> extent [

	^ 640 @ 480
]

{ #category : #'instance creation' }
Tracer1 >> findClassesForPackages: aCollection [

	| items |
	aCollection isEmpty ifTrue: [ 
		^ self baseClass withAllSubclasses asSet ].
	items := aCollection flatCollect: [ :category | 
		         ((Smalltalk organization listAtCategoryNamed: category) 
			          collect: [ :each | Smalltalk globals at: each ]) select: [ 
			         :each | each includesBehavior: self baseClass ] ].
	^ items asSet
]

{ #category : #'instance creation' }
Tracer1 >> findPackages [

	| visible |
	visible := Set new.
	self baseClass withAllSubclassesDo: [ :each | 
		each category ifNotNil: [ :category | visible add: category ] ].
	^ Array streamContents: [ :stream | 
		  Smalltalk organization categories do: [ :each | 
			  ((visible includes: each) and: [ 
				   packagePattern isNil or: [ 
					   (packagePattern matchesIn: each) isNotEmpty ] ]) ifTrue: [ 
				  stream nextPut: each ] ] ]
]

{ #category : #'instance creation' }
Tracer1 >> hasRunnable [

	^ classesSelected notEmpty
]

{ #category : #'instance creation' }
Tracer1 >> initialize [

	super initialize.
	self
		update
]

{ #category : #'instance creation' }
Tracer1 >> label [
^'Tracer'
]

{ #category : #'instance creation' }
Tracer1 >> open [

	<script: 'self new open'>
	^ self build openInWorld
]

{ #category : #'instance creation' }
Tracer1 >> packageList [
^packages
]

{ #category : #'instance creation' }
Tracer1 >> packageSearchFrame [

	^ LayoutFrame new
		  rightFraction: 0.25;
		  bottomFraction: 0 offset: self theme textFont height + 6
]

{ #category : #'instance creation' }
Tracer1 >> packageSelected [

	^ packageIndex
]

{ #category : #'instance creation' }
Tracer1 >> packagesFrame [

	^ LayoutFrame new
		  rightFraction: 0.25;
		  topOffset: self theme textFont height + 13;
		  bottomOffset: self buttonHeight negated
]

{ #category : #'instance creation' }
Tracer1 >> sortClass: aFirstClass before: aSecondClass [

	| first second |
	first := aFirstClass withAllSuperclasses reversed.
	second := aSecondClass withAllSuperclasses reversed.
	1 to: (first size min: second size) do: [ :index | 
		(first at: index) == (second at: index) ifFalse: [ 
			^ (first at: index) name <= (second at: index) name ] ].
	^ second includes: aFirstClass
]

{ #category : #'instance creation' }
Tracer1 >> update [

	self
		updatePackages;
		updateClasses
]

{ #category : #'instance creation' }
Tracer1 >> updateClasses [

	| classesForCategories |
	classesForCategories := self findClassesForPackages: packagesSelected.

	classPattern ifNotNil: [ 
		classesForCategories := classesForCategories reject: [ :cls | 
			                        (classPattern matchesIn: cls name) isEmpty ] ].

	classes := classesForCategories asArray sort: [ :a :b | 
		           self sortClass: a before: b ].
	classIndex := 0.
	classesSelected := classesSelected
		                   ifNil: [ classesForCategories ]
		                   ifNotNil: [ 
			                   classesSelected select: [ :each | 
				                   classesForCategories includes: each ] ].
	self
		changed: #classList;
		changed: #classSelected;
		changed: #hasRunnable
]

{ #category : #'instance creation' }
Tracer1 >> updatePackages [

	packages := self findPackages.
	packageIndex := 0.
	packagesSelected := packagesSelected
		                    ifNil: [ Set new ]
		                    ifNotNil: [ 
		                    packagesSelected select: [ :each | 
			                    packages includes: each ] ].
	self
		changed: #packageList;
		changed: #packageSelected
]
