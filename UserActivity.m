#import "UserActivity.h"

@implementation UserActivity

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(
  createActivity:(NSString *)activityType
  eligibleForSearch:(BOOL)eligibleForSearch
  eligibleForPublicIndexing:(BOOL)eligibleForPublicIndexing
  eligibleForHandoff:(BOOL)eligibleForHandoff
           title:(NSString *)title
      webpageURL:(NSString *)webpageURL
        userInfo:(NSDictionary *)userInfo
)
{
  // Your implementation here
    NSUserActivity* activity = [[NSUserActivity alloc] initWithActivityType:activityType];

    activity.eligibleForSearch = eligibleForSearch;
    activity.eligibleForPublicIndexing = eligibleForPublicIndexing;
    activity.eligibleForHandoff = eligibleForHandoff;

    activity.title = title;
    activity.webpageURL = [NSURL URLWithString:webpageURL];
    activity.userInfo = userInfo;

    activity.keywords = [NSSet setWithArray:@[title]];

    [activity becomeCurrent];
}

@end
