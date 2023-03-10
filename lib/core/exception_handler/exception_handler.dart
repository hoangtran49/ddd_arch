import 'package:ddd_arch/core/exception/base/app_exception.dart';
import 'package:ddd_arch/core/exception/base/app_exception_wrapper.dart';
import 'package:ddd_arch/core/helper/function.dart';
import 'package:ddd_arch/core/navigation/app_popup_info.dart';

import '../exception/remote/remote_exception.dart';
import '../navigation/app_navigator.dart';

class ExceptionHandler {
  const ExceptionHandler({
    required this.navigator,
    required this.listener,
  });

  final AppNavigator navigator;
  final ExceptionHandlerListener listener;

  Future<void> handleException(
    AppExceptionWrapper appExceptionWrapper,
    String commonExceptionMessage,
  ) async {
    final message =
        appExceptionWrapper.overrideMessage ?? commonExceptionMessage;
    switch (appExceptionWrapper.appException.appExceptionType) {
      case AppExceptionType.remote:
        final exception = appExceptionWrapper.appException as RemoteException;
        switch (exception.kind) {
          case RemoteExceptionKind.refreshTokenFailed:
            await _showErrorDialog(
              isRefreshTokenFailed: true,
              message: message,
              onPressed: Func0(navigator.pop),
            );
            break;
          case RemoteExceptionKind.noInternet:
            return _showErrorSnackBar(
              message: navigator.lang.counterAppBarTitle,
            );
          case RemoteExceptionKind.timeout:
            await _showErrorDialogWithRetry(
              message: message,
              onRetryPressed: Func0(() async {
                navigator.pop();
                await appExceptionWrapper.doOnRetry?.call();
              }),
            );
            break;
          case RemoteExceptionKind.network:
            await _showErrorDialog(
              message: message,
              onPressed: Func0(navigator.pop),
            );
            break;
          case RemoteExceptionKind.serverDefined:
          case RemoteExceptionKind.serverUndefined:
          case RemoteExceptionKind.cancellation:
          case RemoteExceptionKind.unknown:
            {
              await _showErrorDialog(
                message: message,
                onPressed: Func0(() async {
                  navigator.pop();
                }),
              );
              break;
            }
        }
        break;
      case AppExceptionType.parse:
        return _showErrorSnackBar(message: message);
      case AppExceptionType.remoteConfig:
        return _showErrorSnackBar(message: message);
      case AppExceptionType.uncaught:
        return _showErrorSnackBar(message: message);
      case AppExceptionType.validation:
        return _showErrorDialog(message: message);
    }
  }

  void _showErrorSnackBar({
    required String message,
  }) {
    navigator.showErrorSnackBar(message);
  }

  Future<void> _showErrorDialog({
    required String message,
    Func0<void>? onPressed,
    bool isRefreshTokenFailed = false,
  }) async {
    await navigator
        .showDialog(
      AppPopupInfo.confirmDialog(
        message: message,
        onPressed: onPressed,
      ),
    )
        .then((value) {
      if (isRefreshTokenFailed) {
        listener.onRefreshTokenFailed();
      }
    });
  }

  Future<void> _showErrorDialogWithRetry({
    required String message,
    required Func0<void>? onRetryPressed,
  }) async {
    // await navigator.showDialog(AppPopupInfo.errorWithRetryDialog(
    //   message: message,
    //   onRetryPressed: onRetryPressed,
    // ));
  }
}

abstract class ExceptionHandlerListener {
  void onRefreshTokenFailed();
}
