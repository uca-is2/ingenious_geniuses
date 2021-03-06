"
This object has an orderedCollection filled with one LeaderBoardBlock for each player and has the responsability to create this blocks at the moment of the initialization of the Game and also update the order of the blocks after each turn
"
Class {
	#name : #LeaderBoard,
	#superclass : #Object,
	#instVars : [
		'rowsOfPlayers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LeaderBoard class >> with: allThePlayers [
	^ self new initializeWith: allThePlayers
]

{ #category : #initialization }
LeaderBoard >> addRowForA: player [
	| leaderBoardRow |
	leaderBoardRow := LeaderBoardRow forPlayer: player.
	rowsOfPlayers add: leaderBoardRow.
]

{ #category : #query }
LeaderBoard >> compareIf: aRow belongsTo: aPlayer [
	^ aRow player == aPlayer.
]

{ #category : #initialization }
LeaderBoard >> fillRowOfEachPlayerFor: allThePlayers [
	allThePlayers do: [ :player | self addRowForA: player ]
]

{ #category : #initialization }
LeaderBoard >> initializeWith: allThePlayers [.
	rowsOfPlayers := OrderedCollection new.
	self fillRowOfEachPlayerFor: allThePlayers.
	
]

{ #category : #query }
LeaderBoard >> positionOf: aPlayer [
	self withRowOf: aPlayer do: [ :aRow | ^ aRow playerPosition ]
]

{ #category : #query }
LeaderBoard >> rankingOf: aPlayer [
	| positionInTheRanking |
	positionInTheRanking := 1.
	rowsOfPlayers
		do: [ :row | 
			(self compareIf: row belongsTo: aPlayer)
				ifTrue: [ ^ positionInTheRanking ].
			positionInTheRanking := positionInTheRanking + 1 ]
]

{ #category : #query }
LeaderBoard >> roundsMadeBy: aPlayer [
	self withRowOf: aPlayer do: [ :aRow | ^ aRow playerRoundsMade ]
]

{ #category : #query }
LeaderBoard >> thePlayer: aPlayer isWinnerForMaking: numberOfRoundsForTheGameToBeOver [
	self
		withRowOf: aPlayer
		do:
			[ :aRow | ^ aRow currentPlayerHasMadeNumberOf: numberOfRoundsForTheGameToBeOver ]
]

{ #category : #update }
LeaderBoard >> updateOrderOfRows [
	rowsOfPlayers := rowsOfPlayers sort reversed
]

{ #category : #update }
LeaderBoard >> updateRowOfThis: player inA: slotsQuantity forThis: board [
	self
		withRowOf: player
		do: [ :row | 
			row
				changePositionAndRoundsMadeByaPlayer: player
				inASlotsQuantity: slotsQuantity
				forThisBoard: board ]
]

{ #category : #accessing }
LeaderBoard >> winner [
	^ (rowsOfPlayers at: 1) player.
]

{ #category : #utilities }
LeaderBoard >> withRowOf: aPlayer do: aBlockClosure [
	^ rowsOfPlayers
		detect: [ :row | row player == aPlayer ]
		ifFound: aBlockClosure
]
