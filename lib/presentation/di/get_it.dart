import 'package:get_it/get_it.dart';
import 'package:my_youtube/data/datasource/auth_datasource/auth_datasource.dart';
import 'package:my_youtube/data/repositories/auth_repo_impl/auth_repo_impl.dart';
import 'package:my_youtube/domain/repositories/auth_repo/auth_repo.dart';
import 'package:my_youtube/domain/usecases/auth_usecase/get_api.dart';
import 'package:my_youtube/domain/usecases/auth_usecase/signin.dart';
import 'package:my_youtube/presentation/bloc/auth/login/auth_login_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<AuthLoginBloc>(() => AuthLoginBloc(sl()));
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()));
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSource());
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(sl()));
  sl.registerLazySingleton<GetApiUseCase>(() => GetApiUseCase(sl()));
}
