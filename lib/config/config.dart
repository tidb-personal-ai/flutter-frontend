import 'package:flutter/foundation.dart';

@immutable
class Config {

  /// The url of the backend server
  final String backendUrl;

  /// The options used to configure the app.
  const Config({
    required this.backendUrl,
  });

  static Config get currentPlatform {
    if (kReleaseMode) {
      return kReleaseConfig;
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      return kDebugAndroidConfig;
    }
    
    return kDebugConfig;
  }
  
  static const Config kReleaseConfig = Config(
    backendUrl: 'https://tidb-personal-ai.web.app/api/',
  );

  static const Config kDebugConfig = Config(
    backendUrl: 'http://localhost:3000/api/',
  );

  static const Config kDebugAndroidConfig = Config(
    backendUrl: 'http://10.0.2.2:3000/api/',
  );
}

