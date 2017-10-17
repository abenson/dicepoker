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
	NSAutoreleasePool *pool;
	NSEnumerator *en;
	Player *obj;
	Game *game;

	Player *winner;

	int die = 0;

	char buf[10];
	NSString *str;
	NSScanner *scan;

	srand(time(NULL));

	pool = [[NSAutoreleasePool alloc] init];

	game = [[Game alloc] init];

	[game addPlayer: [[Player player] setBalance: 20]];

	[game addPlayer: [[Player player] setBalance: 20]];


	while([game gameOver] == NO) {
		[game nextRound];
		if(([game round] % 5) == 0) {
			[game adjustMinBet: 2];
		}
		puts([[NSString stringWithFormat:@"Starting a round: %@\n", game] UTF8String]);

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
			puts([[NSString stringWithFormat:@"\nPlayer %d, which dice would you like to reroll (n for none, a for all)?", [obj playerNo]] UTF8String]);
			puts([[NSString stringWithFormat:@"%@", [obj hand]] UTF8String]);
			printf(" 1  2  3  4  5\n> ");
			fflush(stdout);
			fgets(buf, 10, stdin);

			str = [[[NSString stringWithUTF8String: buf] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] retain];

			if([str isEqual: @"n"] || [str isEqual: @""]) {
				continue;
			} else if([str isEqual: @"a"]) {
				[obj roll];
				puts([[NSString stringWithFormat:@"%@", obj] UTF8String]);
				continue;
			} else if([str isEqual: @"q"]) {
				[game endGame];
				break;
			}


			scan = [[NSScanner alloc] initWithString: str];

			while([scan scanInt: &die]) {
				if(die < 1 || die > 5) {
					printf("Ignoring invalid die: %d\n", die);
					continue;
				}
				[obj reroll: (die-1)];
			}
			puts([[NSString stringWithFormat:@"%@\n", obj] UTF8String]);
			[str release];
			[scan release];
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
