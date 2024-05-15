import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:meoscleanarchitecture/core/secrets/app_secrets.dart';
import 'package:meoscleanarchitecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:meoscleanarchitecture/features/auth/domain/usecases/user_sign_up.dart';
import 'package:meoscleanarchitecture/features/auth/domain/usecases/current_user.dart';
import 'package:meoscleanarchitecture/features/auth/domain/usecases/user_sign_in.dart';
import 'package:meoscleanarchitecture/features/auth/domain/repository/auth_repository.dart';
import 'package:meoscleanarchitecture/core/common/widgets/cubits/app_user/app_user_cubit.dart';
import 'package:meoscleanarchitecture/features/auth/data/repository/auth_repository_impl.dart';
import 'package:meoscleanarchitecture/features/auth/data/data_sources/remote/auth_remote_data_source.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  sl.registerLazySingleton(() => supabase.client);

  // Core
  sl.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  // Data sources
  sl
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()),
    )

    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(sl()),
    )

    // Use cases
    ..registerFactory(
      () => UserSignUp(sl()),
    )
    ..registerFactory(
      () => UserSignIn(sl()),
    )
    ..registerFactory(
      () => CurrentUser(sl()),
    )

    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
          userSignUp: sl(),
          userSignIn: sl(),
          currentUser: sl(),
          appUserCubit: sl()),
    );
}
