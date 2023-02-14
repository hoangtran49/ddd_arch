import 'package:ddd_arch/di/locator.dart';
import 'package:ddd_arch/presentation/authen/login/blocs/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => getIt(),
      child: _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    //final currentState = context.select((LoginBloc bloc) => bloc.state);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              label: Text('User name'),
            ),
            onChanged: (value) {
              bloc.add(InputUserNameEvent(value));
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Password'),
            ),
            onChanged: (value) {
              bloc.add(InputPasswordEvent(value));
            },
          ),
          TextButton(
            onPressed: () {
              bloc.add(SubmitUserNameEvent());
            },
            child: const Text('Login'),
          )
        ],
      ),
    );
  }
}
