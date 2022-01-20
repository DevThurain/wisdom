import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';
import 'package:wisdom/src/data_source/shared_pref/share_pref_helper.dart';
import 'package:wisdom/src/view_models/auth_provider.dart';
import 'package:wisdom/src/view_models/fun_provider.dart';
import 'package:wisdom/src/view_models/home_provider.dart';
import 'package:wisdom/src/view_models/knowledge_provider.dart';
import 'package:wisdom/src/view_models/post_upload_provider.dart';
import 'package:wisdom/src/view_models/profile_provider.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  await SharedPreferences.getInstance().then((value) =>
      locator.registerLazySingleton(() => SharedPreferenceHelper(value)));
  locator.registerLazySingleton(() => RepositoryImpl());
  locator.registerFactory(() => HomeProvider());
  locator.registerFactory(() => KnowledgeProvider());
  locator.registerFactory(() => FunProvider());
  locator.registerFactory(() => AuthProvider());
  locator.registerFactory(() => PostUploadProvider());
  locator.registerFactory(() => ProfileProvider());

}
