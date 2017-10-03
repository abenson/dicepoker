#import <Foundation/Foundation.h>

#import "Player.h"

@interface Game : NSObject
{
	id m_players;
	int m_round;
	int m_pot;
	int m_minBet;
}

-init;

-addPlayer: player;

-adjustPot: (int)amount;
-(int)pot;
-setPot: (int)amount;


-setMinBet: (int)minBet;

-adjustMinBet: (int)minBetDelta;

-(int)minBet;

-description;
-players;

-(int)round;

-nextRound;
-roundWinner;

-(BOOL)gameOver;

-leaderBoard;

@end