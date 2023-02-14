import 'package:bloc/bloc.dart';
import 'package:ddd_arch/app/navigation/app_navigator.dart';
import 'package:ddd_arch/app/navigation_impl.dart';
import 'package:ddd_arch/application/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'login_state.dart';

part 'login_event.dart';
// part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.authService, this.appNavigator) : super(const LoginState()) {
    on<InputUserNameEvent>(_inputUserName);
    on<InputPasswordEvent>(_inputPassword);
    on<SubmitUserNameEvent>(_submit);
  }

  final AuthService authService;
  final AppNavigator appNavigator;

  Future<void> _inputUserName(
      InputUserNameEvent event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
        username: event.name,
      ),
    );
  }

  Future<void> _inputPassword(
      InputPasswordEvent event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
        username: event.password,
      ),
    );
  }

  Future<void> _submit(
    SubmitUserNameEvent event,
    Emitter<LoginState> emit,
  ) async {
    await authService.login(username: state.username, password: state.password);
    await appNavigator.replaceAllNamed(Routes.home);
  }
}
