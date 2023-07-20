
import 'package:lumios/config/config.dart';
import 'package:lumios/services/backend_rest_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backend_rest_provider.g.dart';

@riverpod
BackendRestService backendRestService(BackendRestServiceRef ref) {
  ref.keepAlive();
  return BackendRestService(
    baseUrl: Config.currentPlatform.backendUrl,
  );
}
