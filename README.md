# react-native-user-activity

Setup iOS `NSUserActivity` object.

# Setup

Install module locally.

```sh
$ npm install --save react-native-user-activity
```

Link using react-native [cli](https://www.npmjs.com/package/react-native-cli).

```sh
$ react-native link react-native-user-activity
```

Declare the activity types that your app supports by including the [NSUserActivityTypes](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW28) key in its Info.plist file.


# Sample usage

```js
import UserActivity from 'react-native-user-activity';

...

componentDidMount() {
  UserActivity.createActivity({
    activityType: 'com.sample.proactive',
    webpageURL: 'http://...',
    eligibleForSearch: true,
    eligibleForPublicIndexing: false,
    eligibleForHandoff: false,
    title: 'Random Place',
    userInfo: {},
    locationInfo: {
      lat: 39.637737,
      lon: 22.417769
    },
    supportsNavigation: true,
    supportsPhoneCall: true,
    phoneNumber: '...'
  });
}
```