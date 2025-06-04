import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_recomendation_product_event.dart';
part 'get_recomendation_product_state.dart';

class GetRecomendationProductBloc extends Bloc<GetRecomendationProductEvent, GetRecomendationProductState> {
  GetRecomendationProductBloc() : super(GetRecomendationProductInitial()) {
    on<GetRecomendationProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
