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

	int i;

	srand(time(NULL));

	pool = [[NSAutoreleasePool alloc] init];

	game = [[Game alloc] init];

	printf("Adding a new player...\n");
	[game addPlayer: [Player player]];

	printf("Adding a new player...\n");
	[game addPlayer: [Player player]];


	for(i=0; i<5; i++) {
		[game nextRound];
		printf("Starting a round: %s\n", [[game description] cString]);

		en = [[game players] objectEnumerator];

		while((obj = [en nextObject]))
		{
			printf("%s\n", [[obj description] cString]);
		}
		winner = [game roundWinner];
		if(winner) {
			printf("Winner: %s\n", [[winner description] cString]);
		} else {
			printf("Match ended in a draw!\n");
		}
	}

	[game release];

	[pool release];

	return 0;
}
