#import "UserActivity.h"
@import CoreSpotlight;

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
  if([NSUserActivity class]){

    if(!self.lastUserActivities) {
      self.lastUserActivities = [@[] mutableCopy];
    }

    NSUserActivity* activity = [[NSUserActivity alloc] initWithActivityType:activityType];

    activity.eligibleForSearch = eligibleForSearch;
    activity.eligibleForPublicIndexing = eligibleForPublicIndexing;
    activity.eligibleForHandoff = eligibleForHandoff;

    activity.title = title;
    activity.webpageURL = [NSURL URLWithString:webpageURL];
    activity.userInfo = userInfo;

    activity.keywords = [NSSet setWithArray:@[title]];
    
    if ([CSSearchableItemAttributeSet class]) {
        CSSearchableItemAttributeSet *contentSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:activityType];
        contentSet.title = title;
        contentSet.URL = [NSURL URLWithString:webpageURL];
        activity.contentAttributeSet = contentSet;
    }

    self.lastUserActivity = activity;
    [self.lastUserActivities addObject:activity];
    [activity becomeCurrent];

    if (self.lastUserActivities.count > 5) {
      [self.lastUserActivities removeObjectAtIndex:0];
    }
  }
}

@end
