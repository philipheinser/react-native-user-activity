#import "RCTBridgeModule.h"
#import <Foundation/Foundation.h>

@interface UserActivity : NSObject <RCTBridgeModule>

@property NSUserActivity *lastUserActivity;

@end
