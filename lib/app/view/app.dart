import 'package:fitness/app/cubit/app_cubit.dart';
import 'package:fitness/data/health_client.dart';
import 'package:fitness/home/cubit/home_cubit.dart';
import 'package:fitness/home/view/home_page.dart';
import 'package:fitness/l10n/l10n.dart';
import 'package:fitness/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.healthClient}) : super(key: key);

  final HealthClient healthClient;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: RepositoryProvider(
        create: (context) => healthClient,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HomeCubit>(
              create: (context) =>
                  HomeCubit(healthClient: healthClient)..fetchHealthData(),
            ),
            BlocProvider(
              create: (context) => AppCubit(),
            )
          ],
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              if (state is AppSplash) {
                return SplashPage.route();
              } else if (state is AppHome) {
                return const HomePage();
              } else {
                return const Scaffold();
              }
            },
          ),
        ),
      ),
    );
  }
}
