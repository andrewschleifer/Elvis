
#import "ApplicationDelegate.h"

@implementation ApplicationDelegate

- (BOOL) applicationShouldOpenUntitledFile: (NSApplication *) sender  
{
    NSLog(@"application should open file");
    return NO;
}

@end
