#import "CallNotificationPlugin.h"
#if __has_include(<call_notification/call_notification-Swift.h>)
#import <call_notification/call_notification-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "call_notification-Swift.h"
#endif

@implementation CallNotificationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCallNotificationPlugin registerWithRegistrar:registrar];
}
@end
