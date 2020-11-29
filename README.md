divvy-client-ios
=================

Divvy iOS Client

### Instructions:

```
git clone git@github.com:xdv/divvy-client-ios.git
cd divvy-client-ios
pod install
open Divvy.xcworkspace
```


### Disable Apple App store digital currency restrictions:

Change flag to NO in the RPGlobals.h file 

https://github.com/xdv/divvy-client-ios/blob/master/Divvy/RPGlobals.h#L18

```
// Required for the Apple App Store
#define GLOBAL_RESTRICT_DIGITAL_CURRENCIES       NO
```
