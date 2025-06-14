import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:skinisense/domain/provider/authentication_provider.dart';
import 'package:skinisense/domain/provider/forgot_password_provider.dart';
import 'package:skinisense/domain/provider/product_provider.dart';
import 'package:skinisense/domain/provider/question_provider.dart';
import 'package:skinisense/domain/provider/routine_provider.dart';
import 'package:skinisense/domain/provider/skin_condition_provider.dart';
import 'package:skinisense/domain/services/sharedPreferences-services.dart';
import 'package:skinisense/presentation/ui/pages/features/auth/bloc/auth_bloc.dart';
import 'package:skinisense/presentation/ui/pages/features/auth/repository/auth_repository.dart';
import 'package:skinisense/domain/services/api_client.dart';
import 'package:skinisense/domain/services/token-service.dart';
import 'package:skinisense/presentation/ui/pages/features/home/repository/routine_repository.dart';
import 'package:skinisense/presentation/ui/pages/features/home/repository/skin_condition_repository.dart';
import 'package:skinisense/presentation/ui/pages/features/product/repository/product_repository.dart';
import 'package:skinisense/presentation/ui/pages/features/questions/repository/question_repository.dart';
import 'package:skinisense/presentation/ui/pages/features/result/provider/result_provider.dart';
import 'package:skinisense/presentation/ui/pages/features/result/repositories/result_repositories.dart';

final di = GetIt.instance;

void init() async {
  //   final ApiClient apiClient;
  // final AuthProvider authProvider;
  // final TokenService tokenService;
  // Mendaftarkan AuthRepository dan ProductProvider sebagai singleton
  di.registerSingleton<Dio>(Dio());
  di.registerSingleton<TokenService>(TokenService());
  di.registerSingleton<ApiClient>(ApiClient(di<TokenService>()));
  di.registerSingleton<AuthenticationProvider>(
      AuthenticationProvider(di<ApiClient>()));
  di.registerSingleton<SharedPreferencesService>(SharedPreferencesService());
  // auth
  di.registerSingleton<AuthRepository>(AuthRepository(
      di<ApiClient>(),
      di<AuthenticationProvider>(),
      di<TokenService>(),
      di<SharedPreferencesService>()));
  di.registerSingleton<AuthBloc>(
      AuthBloc(authRepository: di<AuthRepository>()));

  // Forgot password
  di.registerSingleton<ForgotPasswordProvider>(ForgotPasswordProvider(di<ApiClient>())); 
  // Product
  di.registerSingleton<ProductProvider>(ProductProvider(di<ApiClient>()));

  di.registerSingleton<ProductRepository>(
      ProductRepository(di<ProductProvider>()));

  // skin condition
  di.registerSingleton<SkinConditionProvider>(SkinConditionProvider());
  di.registerSingleton<SkinConditionRepository>(
      SkinConditionRepository(di<SkinConditionProvider>()));

  // routine

  di.registerSingleton<RoutineProvider>(RoutineProvider(di<ApiClient>()));
  di.registerSingleton<RoutineRepository>(
      RoutineRepository(di<RoutineProvider>()));

  //question
  di.registerSingleton<QuestionProvider>(QuestionProvider(di<ApiClient>()));
  di.registerSingleton<QuestionRepository>(
      QuestionRepository(di<QuestionProvider>()));
  

  // scan 
  di.registerSingleton<ResultProvider>(ResultProvider(di<ApiClient>()));
  di.registerSingleton<ResultRepositories>(ResultRepositories(di<ResultProvider>()));
}
