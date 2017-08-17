#import <Foundation/Foundation.h>

#import "Game.h"
#import "Player.h"
#import "Die.h"

int main(int argc, char *argv[])
{
	id pool;
	id en, obj;
	id game;

	pool = [[NSAutoreleasePool alloc] init];

	game = [[Game alloc] init];

	NSLog(@"Adding a new player...");
	[game addPlayer: [Player player]];

	NSLog(@"Adding a new player...");
	[game addPlayer: [Player player]];


	NSLog(@"Starting a round: %@", game);

	NSLog(@"Rolling...");

	[game roll];

	en = [[game players] objectEnumerator];

	while(obj = [en nextObject])
	{
		NSLog(@"%@", obj);
	}

	[game release];

	[pool release];

	return 0;
}