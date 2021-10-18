#import <Foundation/Foundation.h>

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#import "Game.h"
#import "Player.h"
#import "Die.h"
#import "PlayerHand.h"

int PrintToStream(FILE *stream, NSString *format, va_list args)
{
	int ret;
	NSString *string;
	string = [[NSString alloc] initWithFormat: format  arguments: args];
	ret = fprintf(stream, "%s", [string cStringUsingEncoding: NSASCIIStringEncoding]);
	[string release];
	return ret;
}

int Print(NSString *format, ...)
{
	int ret;
	va_list args;
	va_start (args, format);
	ret = PrintToStream(stdout, format, args);
	va_end (args);
	return ret;
}

int PrintErr(NSString *format, ...)
{
	int ret;
	va_list args;
	va_start (args, format);
	ret = PrintToStream(stderr, format, args);
	va_end (args);
	return ret;
}

NSString* ReadLineF(FILE *input, size_t len)
{
	char *r_str, *r_val;
	NSString *str = NULL;

	r_str = malloc(len + 1);
	r_val = fgets(r_str, len, input);

	if(r_val) {
		str = [NSString stringWithUTF8String: r_str];
	}

	free(r_str);

	return str;
}

NSString* ReadLine(void)
{
	return ReadLineF(stdin, 255);
}

int main(int argc, char *argv[])
{
	NSAutoreleasePool *pool;
	NSEnumerator *en;
	Player *obj;
	Game *game;

	Player *winner;

	int die = 0;

	NSString *str;
	NSScanner *scan;

	srandom(time(NULL));

	pool = [[NSAutoreleasePool alloc] init];

	game = [[Game alloc] init];

	[game addPlayer: [[Player player] setBalance: 20]];

	[game addPlayer: [[Player player] setBalance: 20]];


	while([game gameOver] == NO) {
		[game nextRound];
		if(([game round] % 5) == 0) {
			[game adjustMinBet: 2];
		}
		Print(@"\nStarting a round: %@\n", game);

		/* initial roll */
		en = [[game players] objectEnumerator];
		while((obj = [en nextObject]))
		{
			Print(@"%@\n", obj);
		}

		/* offer chance to reroll */
		en = [[game players] objectEnumerator];
		while((obj = [en nextObject]))
		{
			NSString *lineRead;
			Print(@"\nPlayer %d, which dice would you like to reroll (n for none, a for all)?\n", [obj playerNo]);
			Print(@"%@\n", [obj hand]);
			Print(@" 1  2  3  4  5\n> ");
			fflush(stdout);

			lineRead = ReadLine();

			if(lineRead == NULL) {
				Print(@"Ending game!\n");
				[game endGame];
				break;
			}

			str = [[lineRead stringByTrimmingCharactersInSet:
				[NSCharacterSet whitespaceAndNewlineCharacterSet]] retain];

			if([str isEqual: @"n"] || [str isEqual: @""]) {
				continue;
			} else if([str isEqual: @"a"]) {
				[obj roll];
				Print(@"%@", obj);
				continue;
			} else if([str isEqual: @"q"]) {
				[game endGame];
				break;
			}


			scan = [[NSScanner alloc] initWithString: str];

			while([scan scanInt: &die]) {
				if(die < 1 || die > 5) {
					Print(@"Ignoring invalid die: %d\n", die);
					continue;
				}
				[obj reroll: (die-1)];
			}
			Print(@"%@\n", obj);
			[str release];
			[scan release];
		}

		winner = [game roundWinner];
		if(winner) {
			[winner addWin];
			[winner adjustBalance: [game pot]];
			[game setPot: 0];
			Print(@"\nWinner: %@\n", winner);
		} else {
			Print(@"\nMatch ended in a draw!\n");
		}
	}

	winner = [[game leaderBoard] objectAtIndex: 0];
	Print(@"Game Winner: %@\n", winner);


	[game release];

	[pool release];

	return 0;
}
