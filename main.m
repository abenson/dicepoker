#import <Foundation/Foundation.h>

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#import "Game.h"
#import "Player.h"
#import "Die.h"
#import "PlayerHand.h"

int main(int argc, char *argv[])
{
	id pool;
	id en, obj;
	id game;

	id winner;

	BOOL cont = YES;

	srand(time(NULL));

	pool = [[NSAutoreleasePool alloc] init];

	game = [[Game alloc] init];

	printf("Adding a new player...\n");
	[game addPlayer: [[Player player] setBalance: 20]];

	printf("Adding a new player...\n");
	[game addPlayer: [[Player player] setBalance: 20]];


	while([game gameOver] == NO) {
		[game nextRound];
		if(([game round] % 5) == 0) {
			[game adjustMinBet: 2];
		}
		printf([[NSString stringWithFormat:@"Starting a round: %@\n", game] UTF8String]);

		en = [[game players] objectEnumerator];
		while((obj = [en nextObject]))
		{
			printf([[NSString stringWithFormat:@"%@\n", obj] UTF8String]);
		}

		winner = [game roundWinner];
		if(winner) {
			printf([[NSString stringWithFormat:@"Winner: %@\n", winner] UTF8String]);
			[winner addWin];
			[winner adjustBalance: [game pot]];
			[game setPot: 0];
		} else {
			printf("Match ended in a draw!\n");
		}
	}

	[game release];

	[pool release];

	return 0;
}
