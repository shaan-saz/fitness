part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  const HomeSuccess({
    required this.steps,
    required this.calories,
  });
  final num steps;
  final num calories;

  @override
  List<Object> get props => [steps, calories];
}

class HomeFailure extends HomeState {
  const HomeFailure({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
