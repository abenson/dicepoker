#import "Player.h"

#import "PlayerHand.h"

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

-(int)playerNo
{
	return m_playerNo;
}

-roll
{
	[m_hand makeObjectsPerformSelector:@selector(roll)];
	return self;
}

-reroll: (int)index
{
	Die *die;
	die = [m_hand objectAtIndex: index];
	[die roll];
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

-adjustBalance: (int)delta
{
	m_balance = m_balance + delta;
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
	int high;
	PlayerHand ph;

	ph = ScoreHand(m_hand, &high);

	return [NSString stringWithFormat:
		@"Player %d: Balance: $%d, Wins: %d, Hand: %@ %@, High: %d",
		m_playerNo,
		m_balance,
		m_wins,
		stringForPlayerHand(ph),
		m_hand,
		high];
}

-(NSComparisonResult)compare: player
{
	PlayerHand myScore, theirScore;
	int myHigh, theirHigh;

	myScore = ScoreHand(m_hand, &myHigh);
	theirScore = ScoreHand([player hand], &theirHigh);

	if(myScore < theirScore) {
		return NSOrderedAscending;
	}

	if(myScore > theirScore) {
		return NSOrderedDescending;
	}

	if(myHigh < theirHigh) {
		return NSOrderedAscending;
	}

	if(myHigh > theirHigh) {
		return NSOrderedDescending;
	}

	return NSOrderedSame;
}


-(NSComparisonResult)compareBalance: player
{
	if(m_balance < [player balance]) {
		return NSOrderedDescending;
	} else if(m_balance > [player balance]) {
		return NSOrderedAscending;
	}
	return NSOrderedSame;
}

@end
