#import "UserActivity.h"
@import CoreSpotlight;
@import MapKit;

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
    locationInfo:(NSDictionary *)locationInfo
supportsNavigation:(BOOL)supportsNavigation
supportsPhoneCall:(BOOL)supportsPhoneCall
      phoneNumber:(NSString *)phoneNumber
      description:(NSString *)description
     thumbnailURL:(NSString *)thumbnailURL
       identifier:(NSString *)identifier
)
{
  // Your implementation here
  if([NSUserActivity class] && [NSUserActivity instancesRespondToSelector:@selector(setEligibleForSearch:)]){

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
        if (description) {
            contentSet.contentDescription = description;
        }
        if (thumbnailURL) {
            contentSet.thumbnailURL = [NSURL fileURLWithPath:thumbnailURL];
        }
        if (identifier) {
            contentSet.identifier = identifier;
        }
        if (phoneNumber) {
            contentSet.phoneNumbers = @[phoneNumber];
        }
        contentSet.supportsNavigation = @(supportsNavigation);
        contentSet.supportsPhoneCall = @(supportsPhoneCall);
        activity.contentAttributeSet = contentSet;
    }
    if ([activity respondsToSelector:@selector(mapItem)] && [locationInfo objectForKey:@"lat"] && [locationInfo objectForKey:@"lon"]) {
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake([locationInfo[@"lat"] doubleValue], [locationInfo[@"lon"] doubleValue])];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        mapItem.name = title;
        mapItem.url = [NSURL URLWithString:webpageURL];
        activity.mapItem = mapItem;
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
