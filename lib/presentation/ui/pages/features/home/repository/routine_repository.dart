import 'package:skinisense/domain/model/routine.dart';
import 'package:skinisense/domain/provider/routine_provider.dart';

class RoutineRepository {
  final RoutineProvider _routineProvider;

  RoutineRepository(this._routineProvider);
  Future<List<Routine>> fetchRoutine() async {
    try {
      return await _routineProvider.getRoutine();
    } catch (e) {
      throw Exception('Failed to fetch skin condition: $e');
    }
  }
}
