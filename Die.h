#import <Foundation/Foundation.h>

@interface Die : NSObject
{
	int m_value;
}

+die;

-init;

-(int)value;

-(int)roll;

-description;

-(NSComparisonResult)compare: die;

@end