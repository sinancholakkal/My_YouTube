import 'package:get_it/get_it.dart';
import 'package:my_youtube/data/datasource/auth_datasource/auth_datasource.dart';
import 'package:my_youtube/data/datasource/search_datasource/search_datasource.dart';
import 'package:my_youtube/data/repositories/auth_repo_impl/auth_repo_impl.dart';
import 'package:my_youtube/data/repositories/search_repo_impl/search_repo_impl.dart';
import 'package:my_youtube/domain/repositories/auth_repo/auth_repo.dart';
import 'package:my_youtube/domain/repositories/search_repo/search_repo.dart';
import 'package:my_youtube/domain/usecases/auth_usecase/get_api.dart';
import 'package:my_youtube/domain/usecases/auth_usecase/signin.dart';
import 'package:my_youtube/domain/usecases/search_usecase/fetchsearch_video.dart';
import 'package:my_youtube/presentation/bloc/auth/login/auth_login_bloc.dart';
import 'package:my_youtube/presentation/bloc/search/fetc_search/fetch_search_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<AuthLoginBloc>(() => AuthLoginBloc(sl()));
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()));
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSource());
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(sl()));
  sl.registerLazySingleton<GetApiUseCase>(() => GetApiUseCase(sl()));

  //Search
  sl.registerLazySingleton<SearchRepo>(() => SearchRepoImpl(sl()));
  sl.registerLazySingleton<FetchSearchVideo>(() => FetchSearchVideo(sl()));
  sl.registerLazySingleton<FetchSearchBloc>(() => FetchSearchBloc(sl()));
  sl.registerLazySingleton<SearchDataSource>(() => SearchDataSource());
}
