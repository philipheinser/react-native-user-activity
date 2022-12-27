import { NativeModules } from 'react-native';

const NativeUserActivity = NativeModules.UserActivity;

/**
 * High-level docs for the UserActivity iOS API can be written here.
 */

type ActivityOptions = {
  activityType: string;
  eligibleForSearch: boolean;
  eligibleForPublicIndexing: boolean;
  eligibleForHandoff: boolean;
  title: string;
  webpageURL: string;
  userInfo: any;
  locationInfo: any;
  supportsNavigation: boolean;
  supportsPhoneCall: boolean;
  phoneNumber: string;
  description: string;
  thumbnailURL: string;
  identifier: string;
};

const UserActivity = {
  createActivity: function (options: ActivityOptions) {
    NativeUserActivity.createActivity(
      options.activityType,
      options.eligibleForSearch,
      options.eligibleForPublicIndexing,
      options.eligibleForHandoff,
      options.title,
      options.webpageURL,
      options.userInfo,
      options.locationInfo,
      options.supportsNavigation || false,
      options.supportsPhoneCall || false,
      options.phoneNumber,
      options.description,
      options.thumbnailURL,
      options.identifier
    );
  },
};

export default UserActivity;
