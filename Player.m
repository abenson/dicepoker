#import "Player.h"

int playerCount = 1;

@implementation Player

+player
{
	return [[[self alloc] init] autorelease];
}

-init
{
	self = [super init];
	if(self) {
		m_playerNo = playerCount++;
		m_wins = 0;
		m_hand = [[NSArray alloc] initWithObjects:
			[Die die],
			[Die die],
			[Die die],
			[Die die],
			[Die die],
			nil];
	}
	return self;
}

-roll
{
	[m_hand makeObjectsPerformSelector:@selector(roll)];
	return self;
}

-hand
{
	return m_hand;
}

-(int)balance
{
	return m_balance;
}

-setBalance: (int)balance
{
	m_balance = balance;
	return self;
}

-(int)wins
{
	return m_wins;
}

-addWin
{
	m_wins += 1;
	return self;
}

-description
{
	return [NSString stringWithFormat: @"Player %d: Balance: $%d, Wins: %d, Hand: %@",
		m_playerNo,
		m_balance,
		m_wins,
		m_hand];
}

@end