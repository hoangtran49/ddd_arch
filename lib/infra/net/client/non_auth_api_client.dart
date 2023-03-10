import 'package:ddd_arch/infra/net/client/base/rest_api_client.dart';
import 'package:ddd_arch/infra/net/interceptor/header_inteceptor.dart';
import 'package:ddd_arch/shared/constants/url_constant.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NoneAuthAppServerApiClient extends RestApiClient {
  NoneAuthAppServerApiClient(
    HeaderInterceptor headerInterceptor,
  ) : super(
          baseUrl: UrlConstants.appApiBaseUrl,
          interceptors: [
            headerInterceptor,
          ],
        );
}
