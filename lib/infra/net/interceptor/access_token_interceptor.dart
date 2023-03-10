import 'package:ddd_arch/infra/net/interceptor/base_interceptor.dart';
import 'package:ddd_arch/infra/preference/app_preference.dart';
import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';

@Injectable()
class AccessTokenInterceptor extends BaseInterceptor {
  AccessTokenInterceptor(this.appPreference);

  @override
  int get priority => BaseInterceptor.accessTokenPriority;

  final AppPreference appPreference;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = appPreference.accessToken;

    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
