import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState.initial());

  Future<void> startSplash() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(const SplashState.loadingAlign());
    await Future<void>.delayed(const Duration(milliseconds: 200));
    emit(const SplashState.loadingVisible());
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(const SplashState.success());
  }
}
