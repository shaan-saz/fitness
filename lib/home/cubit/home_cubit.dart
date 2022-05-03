import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/data/health_client.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required HealthClient healthClient})
      : _healthClient = healthClient,
        super(HomeInitial());

  final HealthClient _healthClient;

  Future<void> fetchHealthData() async {
    try {
      emit(HomeLoading());
      final healthData = await _healthClient.fetchHealthData();
      emit(
        HomeSuccess(
          steps: healthData.first.value,
          calories: healthData.last.value,
        ),
      );
    } on FetchHealthFailure catch (e) {
      emit(
        HomeFailure(
          error: e.toString(),
        ),
      );
    }
  }
}
