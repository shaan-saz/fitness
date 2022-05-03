part of 'splash_cubit.dart';

enum SplashStatus {
  initial,
  loading,
  success,
}

class SplashState extends Equatable {
  const SplashState._({
    this.status = SplashStatus.initial,
    this.visible = false,
    this.align = false,
  });

  const SplashState.initial() : this._();

  const SplashState.loadingVisible()
      : this._(status: SplashStatus.loading, visible: true, align: true);
  const SplashState.loadingAlign()
      : this._(
          status: SplashStatus.loading,
          align: true,
        );

  const SplashState.success() : this._(status: SplashStatus.success);

  final SplashStatus status;
  final bool visible;
  final bool align;

  @override
  List<Object> get props => [status, visible, align];
}
