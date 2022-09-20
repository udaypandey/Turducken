### 1.1
- Fixes to beacons detection and pinging.
- Beacon Uniqueness throttling is now customizable via API.
- NOTE: `BeaconRangeActionsQueue` was divided into two queues: `BeaconRangeActionsHistory` and `BeaconRangeActionsSendList`.
- REMOVED: `didUpdateBeaconRangeActionsQueue` callback is no longer available.
- New `didUpdateBeaconRangeActionsHistory` and `didUpdateBeaconRangeActionsSendList` are now available.

### 1.0.1
SDK was sending the wrong SDK version to the servers
### 1.0
Introducing `FanMakerSDKBeaconsManager` and `FanMakerSDKBeaconsManagerDelegate` to handle FanMaker's Beacons tracking features.

### 0.1.7
Identifiers are now set on users login (via FanMakerSDK UI) and accessible via public variables.
