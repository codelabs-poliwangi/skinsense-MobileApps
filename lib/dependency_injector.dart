import 'package:get_it/get_it.dart';
import 'package:skinisense/domain/provider/auth_provider.dart';
import 'package:skinisense/domain/provider/product_provider.dart';
import 'package:skinisense/presentation/ui/pages/features/auth/repository/auth_repository.dart';
import 'package:skinisense/domain/services/api_client.dart';
import 'package:skinisense/domain/services/token-service.dart';
import 'package:skinisense/presentation/ui/pages/features/product/repository/product_repository.dart';

final di = GetIt.instance;

void init() {
  //   final ApiClient apiClient;
  // final AuthProvider authProvider;
  // final TokenService tokenService;
  // Mendaftarkan AuthRepository dan ProductProvider sebagai singleton
  di.registerSingleton<TokenService>(TokenService());
  di.registerSingleton<ApiClient>(ApiClient(di<TokenService>()));
  
  // auth
  di.registerSingleton<AuthProvider>(AuthProvider(di<ApiClient>()));
  di.registerSingleton<AuthRepository>(
      AuthRepository(di<ApiClient>(), di<AuthProvider>(), di<TokenService>()));

  // Product 
  di.registerSingleton<ProductProvider>(ProductProvider(di<ApiClient>()));

  di.registerSingleton<ProductRepository>(
      ProductRepository(di<ProductProvider>()));
  
  // skin condition
  

  // routine 

  // hive databse local

  // connectiviy
}

