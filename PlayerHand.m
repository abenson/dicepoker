
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
	id en, sorted;
	int bestHand, c;
	id count, counts;
	Die *die;
	NSNumber *number, *key;

	counts = [[NSMutableDictionary alloc] init];

	sorted = [hand sortedArrayUsingSelector: @selector(compare:)];

	bestHand = Nothing;

	en = [sorted objectEnumerator];

	while((die = [en nextObject])) {
		count = [counts objectForKey: [NSNumber numberWithInt: [die value]]];
		if(count == nil) {
			[counts setObject: [NSNumber numberWithInt: 1] forKey: [NSNumber numberWithInt: [die value]]];
		} else {
			[counts setObject: [NSNumber numberWithInt: ([count intValue]+1)] forKey: [NSNumber numberWithInt: [die value]]];
		}
	}

	en = [counts keyEnumerator];


	/* Find multiples */
	while((key = [en nextObject])) {
		number = [counts objectForKey: key];
		if([number intValue] == 2) {
			if(bestHand == Pair) {
				bestHand = TwoPair;
				if(*highVal < [key intValue]) {
					*highVal = [key intValue];
				}
			} else if(bestHand == Set) {
				bestHand = FullHouse;
			} else {
				bestHand = Pair;
				*highVal = [key intValue];
			}
		}
		if([number intValue] == 3) {
			if(bestHand == Pair) {
				bestHand = FullHouse;
				*highVal = [key intValue];
			} else {
				bestHand = Set;
				*highVal = [key intValue];
			}
		}
		if([number intValue] == 4) {
			bestHand = FourAKind;
			*highVal = [key intValue];
		}
		if([number intValue] == 5) {
			bestHand = FiveAKind;
			*highVal = [key intValue];
		}
	}

	/*Find straights*/
	if(bestHand == Nothing) {
		en = [sorted objectEnumerator];
		die = [en nextObject];
		c = [die value];
		if(c < 2) {
			while((die = [en nextObject])) {
				if([die value] != ++c) {
					break;
				}
			}
			if(c == 5) {
				bestHand = LowStraight;
			} else if(c == 6) {
				bestHand = HighStraight;
			}
		}

	}

	/* If all else, find the high card */
	if(bestHand == Nothing) {
		en = [counts keyEnumerator];
		key = [en nextObject];
		*highVal = [key intValue];
		while((key = [en nextObject])) {
			if(*highVal < [key intValue]) {
				*highVal = [key intValue];
			}
		}
	}

	[counts release];

	return bestHand;
}
