#import "Game.h"

@implementation Game

-init
{
	self = [super init];
	if(self) {
		m_players = [[NSMutableArray alloc] init];
		m_pot = 0;
	}
	return self;
}

-addPlayer: player
{
	[m_players addObject: player];
	return self;
}

-raisePot: (int)amount
{
	m_pot += amount;
	return self;
}

-(int)pot
{
	return m_pot;
}

-description
{
	return [NSString stringWithFormat: @"%d Players, Pot is $%d", [m_players count], m_pot];
}

-players
{
	return m_players;
}

-roll
{
	[m_players makeObjectsPerformSelector:@selector(roll)];
	return self;
}

@end
