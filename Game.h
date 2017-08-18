#import <Foundation/Foundation.h>

#import "Player.h"

@interface Game : NSObject
{
	id m_players;
	int m_round;
	int m_pot;
}

-init;

-addPlayer: player;

-raisePot: (int)raiseAmount;
-(int)pot;

-description;
-players;

-nextRound;
-roundWinner;

@end