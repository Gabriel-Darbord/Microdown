Class {
	#name : #MicUrlResolver,
	#superclass : #MicAbstractResolver,
	#instVars : [
		'currentWorkingDirectory',
		'baseUrl'
	],
	#category : #'Microdown-Core'
}

{ #category : #accessing }
MicUrlResolver >> baseUrl [

	^ baseUrl
]

{ #category : #accessing }
MicUrlResolver >> baseUrlString: anObject [

	baseUrl := anObject
]

{ #category : #'accessing - resources' }
MicUrlResolver >> basicResolveAbsoluteFilePath: anAbsoluteMicFileReference [ 

	| fileReference |
	fileReference := currentWorkingDirectory resolvePath: anAbsoluteMicFileReference path.
	fileReference exists 	
		ifFalse: [ ^ MicNotFoundResource resource: anAbsoluteMicFileReference ].
	^ MicFileResource on: fileReference reference: anAbsoluteMicFileReference
]

{ #category : #resolving }
MicUrlResolver >> basicResolveRelativeReference: aMicRelativeReference [ 
	
	| fileReference |
	(fileReference := currentWorkingDirectory / aMicRelativeReference originalString)
		exists ifTrue: [ 
			^ MicFileResource on: fileReference reference: aMicRelativeReference
		 ].
	
	^ self basicResolveUrl: (MicResourceReference fromUri: (baseUrl, aMicRelativeReference originalString))
]

{ #category : #resolving }
MicUrlResolver >> basicResolveUrl: anAbsoluteFileURL [

	| client |
	[
	
	(anAbsoluteFileURL uri asZnUrl asZnUrlWithDefaults)
		hasHost ifFalse: [ ZnMissingHost signal: 'Invalid Url: ', anAbsoluteFileURL uri ].
	
	(client := ZnEasy client)
		url: anAbsoluteFileURL uri;
		enforceHttpSuccess: true;
		get ] on: ZnHttpUnsuccessful, ZnMissingHost do: [ :error |
			^ MicNotFoundResource resource: anAbsoluteFileURL error: error ].

	^ MicHttpResource on: client entity reference: anAbsoluteFileURL
]

{ #category : #accessing }
MicUrlResolver >> currentWorkingDirectory [

	^ currentWorkingDirectory
]

{ #category : #accessing }
MicUrlResolver >> currentWorkingDirectory: anObject [

	currentWorkingDirectory := anObject
]

{ #category : #resolving }
MicUrlResolver >> initialize [

	super initialize.
	"Use by default an empty url, it should fail all requests by default"
	baseUrl := ''.
	"Use an empty in-memory file system that will contain no files"
	currentWorkingDirectory := FileSystem memory.
]