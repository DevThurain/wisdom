import 'package:get_it/get_it.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';
import 'package:wisdom/src/view_models/home_provider.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  locator.registerLazySingleton(() => HomeProvider());
  
  locator.registerLazySingleton(() => RepositoryImpl());
}
