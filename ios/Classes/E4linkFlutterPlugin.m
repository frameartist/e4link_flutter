#import "E4linkFlutterPlugin.h"
#if __has_include(<e4link_flutter/e4link_flutter-Swift.h>)
#import <e4link_flutter/e4link_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "e4link_flutter-Swift.h"
#endif

@implementation E4linkFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftE4linkFlutterPlugin registerWithRegistrar:registrar];
}
@end
