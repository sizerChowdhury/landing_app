import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.g.dart',
  dartOptions: DartOptions(),
  kotlinOut:
      'android/app/src/main/kotlin/dev/flutter/pigeon_example_app/Messages.g.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: 'ios/Runner/Messages.g.swift',
  swiftOptions: SwiftOptions(),
  dartPackageName: 'pigeon_example_package',
))
@FlutterApi()
abstract class DeepLinkApi {
  void getMessage(String message);
}
