import 'package:skinisense/domain/model/skin_condition.dart';
import 'package:skinisense/domain/provider/skin_condition_provider.dart';

class SkinConditionRepository {
  final SkinConditionProvider _skinConditionProvider;

  SkinConditionRepository(this._skinConditionProvider);

  Future<SkinCondition> fetchSkinCondition() async {
    try {
      return await _skinConditionProvider.getSkinCondition();
    } catch (e) {
      throw Exception('Failed to fetch skin condition: $e');
    }
  }
}
