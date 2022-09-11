#ifndef FLUTTER_PLUGIN_E4LINK_FLUTTER_PLUGIN_H_
#define FLUTTER_PLUGIN_E4LINK_FLUTTER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace e4link_flutter {

class E4linkFlutterPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  E4linkFlutterPlugin();

  virtual ~E4linkFlutterPlugin();

  // Disallow copy and assign.
  E4linkFlutterPlugin(const E4linkFlutterPlugin&) = delete;
  E4linkFlutterPlugin& operator=(const E4linkFlutterPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace e4link_flutter

#endif  // FLUTTER_PLUGIN_E4LINK_FLUTTER_PLUGIN_H_
