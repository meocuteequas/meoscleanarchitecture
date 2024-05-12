import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:meoscleanarchitecture/core/secrets/app_secrets.dart';
import 'package:meoscleanarchitecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:meoscleanarchitecture/features/auth/domain/usecases/user_sign_up.dart';
import 'package:meoscleanarchitecture/features/auth/domain/repository/auth_repository.dart';
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
}

void _initAuth() {
  sl.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  sl.registerFactory(
    () => UserSignUp(sl()),
  );

  sl.registerLazySingleton(
    () => AuthBloc(userSignUp: sl()),
  );
}
