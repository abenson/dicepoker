
#import "PlayerHand.h"
#import "Die.h"

NSString *stringForPlayerHand(PlayerHand ph) {
	switch(ph) {
		case Nothing:
			return @"Nothing";
		case Pair:
			return @"Pair";
		case TwoPair:
			return @"Two Pair";
		case Set:
			return @"Set";
		case LowStraight:
			return @"Low Straight";
		case HighStraight:
			return @"High Straight";
		case FullHouse:
			return @"Full House";
		case FourAKind:
			return @"Four of a Kind";
		case FiveAKind:
			return @"Five of a Kind";
		default:
			return @"Unknown";
	}
	return nil;
}

PlayerHand ScoreHand(id hand, int *highVal)
{
	id en, obj, sorted;
	int val, bestHand;

	sorted = [hand sortedArrayUsingSelector: @selector(compare:)];
	en = [sorted objectEnumerator];

	bestHand = Nothing;

	while( (obj = [en nextObject]))	{

	}

	return bestHand;
}
