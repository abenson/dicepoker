#import "Die.h"

@implementation Die

+die
{
	return [[[self alloc] init] autorelease];
}

-init
{
	self = [super init];
	if(self) {
		[self roll];
	}
	return self;
}

-(int)value
{
	return m_value;
}

-(int)roll
{
	m_value = (random() % 6) + 1;
	return m_value;
}

-description
{
	return [NSString stringWithFormat: @"%d", m_value];
}

-(NSComparisonResult)compare: (Die*)die
{
	if([die value] > m_value) {
		return NSOrderedAscending;
	} else if([die value] < m_value) {
		return NSOrderedDescending;
	} else {
		return NSOrderedSame;
	}
}

@end