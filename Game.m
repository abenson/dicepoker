#import "Game.h"

@implementation Game

-init
{
	self = [super init];
	if(self) {
		m_players = [[NSMutableArray alloc] init];
		m_pot = 0;
		m_round = 0;
		m_minBet = 1;
	}
	return self;
}

-addPlayer: player
{
	[m_players addObject: player];
	return self;
}

-setMinBet: (int)minBet
{
	m_minBet = minBet;
	return self;
}

-adjustMinBet: (int)minBetDelta
{
	m_minBet += minBetDelta;
	return self;
}

-(int)minBet
{
	return m_minBet;
}

-setPot: (int)amount
{
	m_pot = amount;
	return self;
}

-adjustPot: (int)amount
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
	return [NSString stringWithFormat: @"Round %d, %d Players, Pot is $%d, Bet is $%d", m_round, [m_players count], m_pot, m_minBet];
}

-players
{
	return m_players;
}

-nextRound
{
	id en;
	Player *player;

	m_round += 1;

	en = [m_players objectEnumerator];
	while((player = [en nextObject])) {
		[player roll];
		[player adjustBalance: -1 * m_minBet];
		[self adjustPot: m_minBet];
	}

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
			case NSOrderedAscending:
				winner = obj;
				break;
			case NSOrderedDescending:
				break;
		}
		if(winner == nil) {
			break;
		}
	}

	return winner;
}

-(int)round
{
	return m_round;
}

-(BOOL)gameOver
{
	id en, obj;
	en = [m_players objectEnumerator];
	while((obj = [en nextObject])) {
		if([obj balance] < m_minBet) {
			return YES;
		}
	}
	return NO;
}

-leaderBoard
{
	return [m_players sortedArrayUsingSelector:@selector(compareBalance:)];
}


@end
