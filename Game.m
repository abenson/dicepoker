#import "Game.h"

@implementation Game

-init
{
	self = [super init];
	if(self) {
		m_players = [[NSMutableArray alloc] init];
		m_pot = 0;
		m_round = 0;
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
	return [NSString stringWithFormat: @"Round %d, %d Players, Pot is $%d", m_round, [m_players count], m_pot];
}

-players
{
	return m_players;
}

-nextRound
{
	m_round += 1;
	[m_players makeObjectsPerformSelector:@selector(roll)];
	return self;
}

-roundWinner
{
	id en, obj;
	id winner = nil;
	NSComparisonResult cmp;

	en = [m_players objectEnumerator];
	winner = [en nextObject];

	while((obj = [en nextObject])) {
		cmp = [winner compare:obj];
		switch(cmp) {
			case NSOrderedSame:
				winner = nil;
				break;
			case NSOrderedDescending:
				winner = obj;
				break;
			case NSOrderedAscending:
				break;
		}
		if(winner == nil) {
			break;
		}
	}

	return winner;
}

@end
