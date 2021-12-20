Class {
	#name : #MicNotFoundResource,
	#superclass : #MicAbstractResource,
	#instVars : [
		'error'
	],
	#category : #'Microdown-Core'
}

{ #category : #'instance creation' }
MicNotFoundResource class >> resource: aResource error: anError [
	
	^ self new
		notFoundReference: aResource;
		error: anError;
		yourself
]

{ #category : #converting }
MicNotFoundResource >> asForm [
	
	^ nil
]

{ #category : #visiting }
MicNotFoundResource >> asRenderedOn: aRenderer withinNode: aNode [
	
	^ aRenderer renderNotFoundResource: self inNode: aNode
]

{ #category : #accessing }
MicNotFoundResource >> error [

	^ error
]

{ #category : #accessing }
MicNotFoundResource >> error: anError [

	error := anError
]

{ #category : #testing }
MicNotFoundResource >> exists [
	
	^ false
]

{ #category : #accessing }
MicNotFoundResource >> notFoundReference [

	^ self reference
]

{ #category : #accessing }
MicNotFoundResource >> notFoundReference: anObject [

	self reference: anObject
]