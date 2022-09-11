#include "include/e4link_flutter/e4link_flutter_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "e4link_flutter_plugin.h"

void E4linkFlutterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  e4link_flutter::E4linkFlutterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
