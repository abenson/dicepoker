#import <Foundation/Foundation.h>

enum {
	Nothing,
	Pair,
	TwoPair,
	Set,
	LowStraight,
	HighStraight,
	FullHouse,
	FourAKind,
	FiveAKind
};

typedef NSInteger PlayerHand;


PlayerHand ScoreHand(id hand, int *highest);
NSString *stringForPlayerHand(PlayerHand ph);
