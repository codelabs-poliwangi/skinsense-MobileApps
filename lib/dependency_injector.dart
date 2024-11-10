import 'package:get_it/get_it.dart';
import 'package:skinisense/domain/model/product.dart';
import 'package:skinisense/domain/provider/auth_provider.dart';
import 'package:skinisense/domain/provider/product_provider.dart';
import 'package:skinisense/domain/repository/auth_repository.dart';
import 'package:skinisense/domain/services/api_client.dart';
import 'package:skinisense/domain/services/token-service.dart';
import 'package:skinisense/domain/utils/logger.dart';
import 'package:skinisense/presentation/ui/pages/features/product/repository/product_repository.dart';

final di = GetIt.instance;

void setupInitial() {
  //   final ApiClient apiClient;
  // final AuthProvider authProvider;
  // final TokenService tokenService;
  // Mendaftarkan AuthRepository dan ProductProvider sebagai singleton
  di.registerSingleton<TokenService>(TokenService());
  di.registerSingleton<ApiClient>(ApiClient(di<TokenService>()));
  di.registerSingleton<AuthProvider>(AuthProvider(di<ApiClient>()));
  di.registerSingleton<AuthRepository>(
      AuthRepository(di<ApiClient>(), di<AuthProvider>(), di<TokenService>()));

  // hive databse local

  // connectiviy
}

void setupRepositoryProduct() {
  di.registerSingleton<ProductProvider>(ProductProvider());
  // Pastikan untuk memberikan dependency yang sesuai jika ProductRepository memerlukan dependency lain
  di.registerLazySingleton<ProductRepository>(
      () => ProductRepository(di<ProductProvider>()));
  logger.i('Product Repository initialized');
  print('Product Repository initialized');
}

void removeRepositoryProduct() {
  // Menghapus ProductRepository jika sudah terdaftar
  if (di.isRegistered<ProductRepository>()) {
    di.unregister<ProductRepository>();
    di.unregister<ProductProvider>();
    logger.i('Product Repository deleted');
    // print('Product Repository deleted');
  }
}
