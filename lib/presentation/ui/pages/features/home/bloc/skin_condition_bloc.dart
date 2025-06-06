import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skinisense/domain/services/sharedPreferences-services.dart';
import 'package:skinisense/presentation/ui/pages/features/home/repository/skin_condition_repository.dart';
import 'package:skinisense/presentation/ui/pages/features/result/model/last_scan_model.dart';

part 'skin_condition_event.dart';
part 'skin_condition_state.dart';

class SkinConditionBloc extends Bloc<SkinConditionEvent, SkinConditionState> {
  final SkinConditionRepository _skinConditionRepository;

  SkinConditionBloc(this._skinConditionRepository)
    : super(SkinConditionInitial()) {
    on<FetchSkinCondition>((event, emit) async {
      emit(SkinConditionInitial());
      try {
        emit(SkinConditionLoading());
        // get last scan from shared preferences
        final String? lastScan = await SharedPreferencesService().getString(
          'last_scan',
        );

        late LastScanModel datalastScan;

        if (lastScan == null) {
          datalastScan = LastScanModel(
            date: null,
            wringkle: 0,
            acne: 0,
            flex: 0,
          );
        } else {
          datalastScan = LastScanModel.fromJson(json.decode(lastScan));
        }

        emit(SkinConditionLoaded(datalastScan));
      } catch (e) {
        emit(SkinConditionError(e.toString()));
      }
    });
  }
}
