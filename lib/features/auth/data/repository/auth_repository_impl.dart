import 'package:fpdart/fpdart.dart';
import 'package:meoscleanarchitecture/core/error/exceptions.dart';
import 'package:meoscleanarchitecture/core/error/failures.dart';
import 'package:meoscleanarchitecture/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:meoscleanarchitecture/features/auth/domain/entities/user.dart';
import 'package:meoscleanarchitecture/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
