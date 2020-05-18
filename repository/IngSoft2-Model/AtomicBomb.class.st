Class {
	#name : #AtomicBomb,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
AtomicBomb >> applyEffectOfSlotOn: aPlayer from: allThePlayers forThe: board for: aNumberOfRounds [
	| playerCurrentPosition |
	allThePlayers
		do: [ :player | 
			playerCurrentPosition := player currentPosition.
			player
				move: playerCurrentPosition * -1
				on: board
				until: aNumberOfRounds ]
]