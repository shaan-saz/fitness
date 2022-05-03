import 'package:health/health.dart';

class HealthClient {
  HealthClient({HealthFactory? healthFactory})
      : _healthFactory = healthFactory ?? HealthFactory();

  final HealthFactory _healthFactory;

  Future<List<HealthDataPoint>> fetchHealthData() async {
    final today = DateTime.now();

    final yesterday = today.subtract(
      const Duration(days: 1),
    );

    var healthData = <HealthDataPoint>[];

    final requested = await _healthFactory.requestAuthorization(
      [
        HealthDataType.STEPS,
        HealthDataType.ACTIVE_ENERGY_BURNED,
      ],
      permissions: [
        HealthDataAccess.READ,
        HealthDataAccess.READ,
      ],
    );

    if (requested) {
      healthData = await _healthFactory.getHealthDataFromTypes(
        yesterday,
        today,
        [
          HealthDataType.STEPS,
          HealthDataType.ACTIVE_ENERGY_BURNED,
        ],
      );
    } else {
      throw FetchHealthFailure();
    }
    return healthData;
  }
}

class FetchHealthFailure implements Exception {}
