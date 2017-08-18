
#import "PlayerHand.h"
#import "Die.h"

NSString *stringForPlayerHand(PlayerHand ph) {
	switch(ph) {
		case Nothing:
			return @"Nothing";
		case Pair:
			return @"Pair";
		case TwoPair:
			return @"TwoPair";
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

PlayerHand ScoreHand(id hand, int *highest)
{
	*highest = 6;
	return Nothing;
}
