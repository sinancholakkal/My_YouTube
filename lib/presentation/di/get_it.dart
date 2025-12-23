import 'package:get_it/get_it.dart';
import 'package:my_youtube/data/datasource/auth_datasource/auth_datasource.dart';
import 'package:my_youtube/data/datasource/format_datasource/format_datasource.dart';
import 'package:my_youtube/data/datasource/search_datasource/search_datasource.dart';
import 'package:my_youtube/data/repositories/auth_repo_impl/auth_repo_impl.dart';
import 'package:my_youtube/data/repositories/format_repo_impl/format_repo_impl.dart';
import 'package:my_youtube/data/repositories/search_repo_impl/search_repo_impl.dart';
import 'package:my_youtube/domain/repositories/auth_repo/auth_repo.dart';
import 'package:my_youtube/domain/repositories/formating/formating_repo.dart';
import 'package:my_youtube/domain/repositories/search_repo/search_repo.dart';
import 'package:my_youtube/domain/usecases/auth_usecase/get_api.dart';
import 'package:my_youtube/domain/usecases/auth_usecase/signin.dart';
import 'package:my_youtube/domain/usecases/formating_usecase/format_count_usecase.dart';
import 'package:my_youtube/domain/usecases/formating_usecase/format_date_usecase.dart';
import 'package:my_youtube/domain/usecases/search_usecase/fetchsearch_video.dart';
import 'package:my_youtube/domain/usecases/search_usecase/fetchsearch_video_nextpage.dart';
import 'package:my_youtube/presentation/bloc/auth/login/auth_login_bloc.dart';
import 'package:my_youtube/presentation/bloc/search/fetc_search/fetch_search_bloc.dart';
import 'package:my_youtube/presentation/bloc/video_details/video_details_bloc.dart';

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
  sl.registerLazySingleton<FetchSearchBloc>(() => FetchSearchBloc(sl(), sl()));
  sl.registerLazySingleton<SearchDataSource>(() => SearchDataSource());
  sl.registerLazySingleton<FetchSearchVideoNextPage>(
    () => FetchSearchVideoNextPage(sl()),
  );

  //Format
  sl.registerLazySingleton<FormatingRepo>(
    () => FormatRepoImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<FormatDataSource>(() => FormatDataSource());
  sl.registerLazySingleton<VideoDetailsBloc>(() => VideoDetailsBloc());
  sl.registerLazySingleton<FormatCountUseCase>(() => FormatCountUseCase(sl()));
  sl.registerLazySingleton<FormatDateUseCase>(() => FormatDateUseCase(sl()));
}
