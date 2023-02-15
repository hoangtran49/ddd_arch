import 'package:ddd_arch/app/blocs/setting_bloc/setting_bloc.dart';
import 'package:ddd_arch/app/blocs/setting_bloc/setting_state.dart';
import 'package:ddd_arch/app/navigation/routes.dart';
import 'package:ddd_arch/app/navigation_impl.dart';
import 'package:ddd_arch/core/resource/config/theme.dart';
import 'package:ddd_arch/di/locator.dart';
import 'package:ddd_arch/l10n/l10n.dart';
import 'package:ddd_arch/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingBloc>(
      create: (context) => getIt()..add(RequestSubcribeSettingEvent()),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});
  @override
  Widget build(BuildContext context) {
    final navigatorKey = NavigationImpl.navigatorKey;
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        final theme = state.themeMode;
        return MaterialApp(
          navigatorKey: navigatorKey,
          routes: Routes.routes,
          themeMode: theme,
          darkTheme: darkTheme,
          // theme: ThemeData(
          //   appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
          //   colorScheme: ColorScheme.fromSwatch(
          //     accentColor: const Color(0xFF13B9FF),
          //   ),
          // ),
          theme: lightTheme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(state.langCode),
          home: const HomePage(),
        );
      },
    );
  }
}