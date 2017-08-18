#import <Foundation/Foundation.h>

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

	int i;

	srand(time(NULL));

	pool = [[NSAutoreleasePool alloc] init];

	game = [[Game alloc] init];

	NSLog(@"Adding a new player...");
	[game addPlayer: [Player player]];

	NSLog(@"Adding a new player...");
	[game addPlayer: [Player player]];


	for(i=0; i<5; i++) {
		[game nextRound];
		NSLog(@"Starting a round: %@", game);

		en = [[game players] objectEnumerator];

		while((obj = [en nextObject]))
		{
			NSLog(@"%@", obj);
		}
		winner = [game roundWinner];
		if(winner) {
			NSLog(@"Winner: %@", winner);
		} else {
			NSLog(@"Match ended in a draw!");
		}
	}

	[game release];

	[pool release];

	return 0;
}
