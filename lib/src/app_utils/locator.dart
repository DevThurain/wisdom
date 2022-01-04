import 'package:get_it/get_it.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';
import 'package:wisdom/src/view_models/fun_provider.dart';
import 'package:wisdom/src/view_models/home_provider.dart';
import 'package:wisdom/src/view_models/knowledge_provider.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  locator.registerLazySingleton(() => RepositoryImpl());
  locator.registerLazySingleton(() => HomeProvider());
  locator.registerLazySingleton(() => KnowlegeProvider());
  locator.registerLazySingleton(() => FunProvider());
}
