//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_keyboard_visibility_temp_fork/FlutterKeyboardVisibilityTempForkPlugin.h>)
#import <flutter_keyboard_visibility_temp_fork/FlutterKeyboardVisibilityTempForkPlugin.h>
#else
@import flutter_keyboard_visibility_temp_fork;
#endif

#if __has_include(<quill_native_bridge_ios/QuillNativeBridgePlugin.h>)
#import <quill_native_bridge_ios/QuillNativeBridgePlugin.h>
#else
@import quill_native_bridge_ios;
#endif

#if __has_include(<sqflite_darwin/SqflitePlugin.h>)
#import <sqflite_darwin/SqflitePlugin.h>
#else
@import sqflite_darwin;
#endif

#if __has_include(<url_launcher_ios/URLLauncherPlugin.h>)
#import <url_launcher_ios/URLLauncherPlugin.h>
#else
@import url_launcher_ios;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterKeyboardVisibilityTempForkPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterKeyboardVisibilityTempForkPlugin"]];
  [QuillNativeBridgePlugin registerWithRegistrar:[registry registrarForPlugin:@"QuillNativeBridgePlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
  [URLLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"URLLauncherPlugin"]];
}

@end
