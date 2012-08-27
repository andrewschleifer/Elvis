
#import "ElvisDocument.h"

@implementation ElvisDocument

- (id) init;
{
    if (!(self = [super init]))
		return nil;
	//	[...initialize my stuff...]
	return self;
}

- (NSString *) windowNibName
{
    NSLog(@"windowNibName");
    return @"ElvisDocument";
}

@end
