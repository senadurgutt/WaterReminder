//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flutter_timezone/flutter_timezone_plugin.h>
#include <local_notifier/local_notifier_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) flutter_timezone_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlutterTimezonePlugin");
  flutter_timezone_plugin_register_with_registrar(flutter_timezone_registrar);
  g_autoptr(FlPluginRegistrar) local_notifier_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "LocalNotifierPlugin");
  local_notifier_plugin_register_with_registrar(local_notifier_registrar);
}
