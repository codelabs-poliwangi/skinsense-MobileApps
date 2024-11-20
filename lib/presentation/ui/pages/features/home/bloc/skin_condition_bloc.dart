import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skinisense/domain/model/skin_condition.dart';
import 'package:skinisense/presentation/ui/pages/features/home/repository/skin_condition_repository.dart';

part 'skin_condition_event.dart';
part 'skin_condition_state.dart';

class SkinConditionBloc extends Bloc<SkinConditionEvent, SkinConditionState> {
  final SkinConditionRepository _skinConditionRepository;

  SkinConditionBloc(this._skinConditionRepository) : super(SkinConditionInitial()) {
    on<FetchSkinCondition>((event, emit) async {
      emit(SkinConditionInitial());
      try {
        emit(SkinConditionLoading());
        final skinCondition = await _skinConditionRepository.fetchSkinCondition();
        emit(SkinConditionLoaded(skinCondition));
      } catch (e) {
        emit(SkinConditionError(e.toString()));
      }
    });
  }
}
