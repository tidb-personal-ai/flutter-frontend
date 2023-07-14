
import 'package:personal_ai/config/config.dart';
import 'package:personal_ai/services/backend_rest_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backend_rest_provider.g.dart';

@riverpod
BackendRestService backendRestService(BackendRestServiceRef ref) {
  ref.keepAlive();
  return BackendRestService(
    baseUrl: Config.currentPlatform.backendUrl,
  );
}
