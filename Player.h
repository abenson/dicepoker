#import <Foundation/Foundation.h>

#import "Die.h"

@interface Player : NSObject
{
	int m_wins;
	int m_playerNo;
	int m_balance;
	id m_hand;
}

+player;

-init;

-(int)playerNo;

-roll;
-reroll: (int) index;
-hand;

-(int)balance;
-setBalance: (int)balance;
-adjustBalance: (int)delta;

-(int)wins;
-addWin;

-description;

-(NSComparisonResult)compare: player;

@end
