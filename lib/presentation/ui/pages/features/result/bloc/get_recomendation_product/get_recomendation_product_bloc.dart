import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../../dependency_injector.dart';
import '../../model/get_recomendation_product_response_model.dart';
import '../../repositories/result_repositories.dart';

part 'get_recomendation_product_event.dart';
part 'get_recomendation_product_state.dart';

class GetRecomendationProductBloc
    extends Bloc<GetRecomendationProductEvent, GetRecomendationProductState> {
  GetRecomendationProductBloc() : super(GetRecomendationProductInitial()) {
    on<GetRecomendationProductEvent>((event, emit) {});
    on<GetRecomendationProductFromScan>(getRecomendation);
  }
  Future<void> getRecomendation(
    GetRecomendationProductFromScan event,
    Emitter<GetRecomendationProductState> emit,
  ) async {
    emit(GetRecomendationProductLoading());
    try {
      final resultRepository = di<ResultRepositories>();
      final String idScan = event.id;
      final result = await resultRepository.getRecomendation(idScan);
      emit(GetRecomendationProductSuccess(dataRecomendation: result));
    } catch (e) {
      emit(GetRecomendationProductFailed(message: e.toString()));
    }
  }
}
