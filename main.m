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

	int die = 0;

	char buf[10];
	NSString *str;
	NSArray *arr;
	id elen, el;

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

		/* initial roll */
		en = [[game players] objectEnumerator];
		while((obj = [en nextObject]))
		{
			puts([[NSString stringWithFormat:@"%@", obj] UTF8String]);
		}

		/* offer chance to reroll */
		en = [[game players] objectEnumerator];
		while((obj = [en nextObject]))
		{
			puts([[NSString stringWithFormat:@"Player %d, which dice would you like to reroll (n for none, a for all)?", [obj playerNo]] UTF8String]);
			puts([[NSString stringWithFormat:@"%@", [obj hand]] UTF8String]);
			printf(" 1  2  3  4  5\n> ");
			fflush(stdout);
			fgets(buf, 10, stdin);
			if(strncmp(buf, "n", 1) == 0) {
				continue;
			} else if(strncmp(buf, "a", 1) == 0) {
				[obj roll];
				puts([[NSString stringWithFormat:@"%@", obj] UTF8String]);
				continue;
			} else if(strncmp(buf, "q", 1) == 0) {
				[game endGame];
				break;
			}

			str = [[[NSString stringWithUTF8String: buf] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] retain];
			arr = [[str componentsSeparatedByString:@" "] retain];
			elen = [arr objectEnumerator];
			while( (el = [elen nextObject])) {
				die = atoi([el UTF8String]);
				if(die < 1 || die > 5) {
					printf("Ignoring invalid die: %s\n", [el UTF8String]);
					continue;
				}
				[obj reroll: (die-1)];
			}
			puts([[NSString stringWithFormat:@"%@", obj] UTF8String]);
			[str release];
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
