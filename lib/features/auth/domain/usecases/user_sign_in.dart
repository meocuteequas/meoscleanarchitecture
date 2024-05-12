import 'package:fpdart/fpdart.dart';
import 'package:meoscleanarchitecture/core/error/failures.dart';
import 'package:meoscleanarchitecture/core/usecase/usecase.dart';
import 'package:meoscleanarchitecture/features/auth/domain/entities/user.dart';
import 'package:meoscleanarchitecture/features/auth/domain/repository/auth_repository.dart';

class UserSignIn implements UseCase<User, UserSignInParams> {
  final AuthRepository authRepository;

  UserSignIn(this.authRepository);

  @override
  Future<Either<Failure, User>> call(params) async {
    return await authRepository.signInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({required this.email, required this.password});
}
