import 'package:fpdart/fpdart.dart';
import 'package:meoscleanarchitecture/core/error/failures.dart';
import 'package:meoscleanarchitecture/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();
}
