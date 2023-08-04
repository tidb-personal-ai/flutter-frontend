
import 'dart:convert';

import 'package:lumios/providers/backend_rest_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'keyword_search_provider.g.dart';


@riverpod
class KeywordSearch extends _$KeywordSearch {

  @override
  FutureOr<int?> build() {
    return null;
  }

  Future<void> search(String keyword) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final api = ref.read(backendRestServiceProvider);
      final result = await api.get('chat/keyword-count', {
        'keyword': keyword,
      });
      final jsonObject = jsonDecode(result) as Map<String, dynamic>;
      return jsonObject['count'] as int;
    });
  }
}
