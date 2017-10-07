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

	srand(time(NULL));

	pool = [[NSAutoreleasePool alloc] init];

	game = [[Game alloc] init];

	puts("Adding a new player...");
	[game addPlayer: [[Player player] setBalance: 20]];

	puts("Adding a new player...");
	[game addPlayer: [[Player player] setBalance: 20]];


	while([game gameOver] == NO) {
		[game nextRound];
		if(([game round] % 5) == 0) {
			[game adjustMinBet: 2];
		}
		puts([[NSString stringWithFormat:@"Starting a round: %@", game] UTF8String]);

		en = [[game players] objectEnumerator];
		while((obj = [en nextObject]))
		{
			puts([[NSString stringWithFormat:@"%@", obj] UTF8String]);
		}

		winner = [game roundWinner];
		if(winner) {
			[winner addWin];
			[winner adjustBalance: [game pot]];
			[game setPot: 0];
			puts([[NSString stringWithFormat:@"Winner: %@\n", winner] UTF8String]);
		} else {
			puts("Match ended in a draw!\n");
		}
	}

	winner = [[game leaderBoard] objectAtIndex: 0];
	puts([[NSString stringWithFormat:@"Game Winner: %@\n", winner] UTF8String]);


	[game release];

	[pool release];

	return 0;
}
