#import <Foundation/Foundation.h>

@interface Game : NSObject
{
	id m_players;

	int m_pot;
}

-init;

-addPlayer: player;

-raisePot: (int)raiseAmount;
-(int)pot;

-description;
-players;

-roll;

@end