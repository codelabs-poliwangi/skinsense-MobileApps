
import 'package:get_it/get_it.dart';
import 'package:skinisense/domain/provider/product_provider.dart';
import 'package:skinisense/domain/repository/auth_repository.dart';
import 'package:skinisense/presentation/ui/pages/features/product/repository/product_repository.dart';

final locator = GetIt.instance;

void setupInitial(){
  // menggunakan registerSingleton auth repository akan dijalankan ketika aplikasi berjalan 
  locator.registerSingleton<AuthRepository>(AuthRepository());
}

void setupRepositoryProduct() {
  ProductProvider productProvider = ProductProvider();
  locator.registerLazySingleton<ProductRepository>(() => ProductRepository(productProvider));
  print('product Repository Initial');
}

void removeRepositoryProduct() {
  if (locator.isRegistered<ProductRepository>()) {
    locator.unregister<ProductRepository>();
     print('product Repository deleted');
  }
}