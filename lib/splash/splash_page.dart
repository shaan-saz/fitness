import 'package:fitness/app/cubit/app_cubit.dart';
import 'package:fitness/constants/font.dart';
import 'package:fitness/constants/image_path.dart';
import 'package:fitness/constants/string.dart';
import 'package:fitness/splash/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  static Widget route() => Builder(
        builder: (_) {
          return BlocProvider(
            create: (context) => SplashCubit()..startSplash(),
            child: const SplashPage(),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final _align = context.select((SplashCubit cubit) => cubit.state.align);
    final _visible = context.select((SplashCubit cubit) => cubit.state.visible);
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.success) {
          context.read<AppCubit>().onHome();
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints.tight(const Size(210, 85)),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 500),
                      alignment:
                          _align ? const Alignment(0.615, 0) : Alignment.center,
                      child: SizedBox(
                        child: Image.asset(
                          ImagePathCommon.splashI,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (_align)
                      AnimatedOpacity(
                        opacity: _visible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 1500),
                        child: SizedBox(
                          child: Image.asset(
                            ImagePath(context).splashBoozin,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(height: 14),
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 1500),
                child: const Text(
                  AppText.fitness,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFont.nunito,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
