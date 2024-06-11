import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:meoscleanarchitecture/core/network/connection_checker.dart';
import 'package:meoscleanarchitecture/features/blog/data/datasources/blog_local_datasource.dart';
import 'package:meoscleanarchitecture/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:meoscleanarchitecture/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:meoscleanarchitecture/features/blog/domain/repositories/blog_repository.dart';
import 'package:meoscleanarchitecture/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:meoscleanarchitecture/features/blog/domain/usecases/upload_blog.dart';
import 'package:meoscleanarchitecture/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:meoscleanarchitecture/core/secrets/app_secrets.dart';
import 'package:meoscleanarchitecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:meoscleanarchitecture/features/auth/domain/usecases/user_sign_up.dart';
import 'package:meoscleanarchitecture/features/auth/domain/usecases/current_user.dart';
import 'package:meoscleanarchitecture/features/auth/domain/usecases/user_sign_in.dart';
import 'package:meoscleanarchitecture/features/auth/domain/repository/auth_repository.dart';
import 'package:meoscleanarchitecture/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:meoscleanarchitecture/features/auth/data/repository/auth_repository_impl.dart';
import 'package:meoscleanarchitecture/features/auth/data/data_sources/remote/auth_remote_data_source.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  sl.registerLazySingleton<SupabaseClient>(() => supabase.client);

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  sl.registerLazySingleton(
    () => Hive.box(name: 'blogs'),
  );

  sl.registerFactory(() => InternetConnection());

  // Core
  sl.registerLazySingleton(() => AppUserCubit());
  sl.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      sl(),
    ),
  );
}

void _initAuth() {
  // Data sources
  sl
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()),
    )

    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl()),
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

void _initBlog() {
  // Datasource
  sl
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        sl(),
      ),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(
        sl(),
      ),
    )
    // Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        sl(),
        sl(),
        sl(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UploadBlog(
        sl(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogs(
        sl(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: sl(),
        getAllBlogs: sl(),
      ),
    );
}
