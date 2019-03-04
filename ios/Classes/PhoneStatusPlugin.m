#import "PhoneStatusPlugin.h"
#import <phone_status/phone_status-Swift.h>

@implementation PhoneStatusPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPhoneStatusPlugin registerWithRegistrar:registrar];
}
@end
