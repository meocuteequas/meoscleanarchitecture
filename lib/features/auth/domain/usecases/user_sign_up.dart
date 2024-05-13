import 'package:fpdart/fpdart.dart';
import 'package:meoscleanarchitecture/core/error/failures.dart';
import 'package:meoscleanarchitecture/core/usecase/usecase.dart';
import 'package:meoscleanarchitecture/core/common/entities/user.dart';
import 'package:meoscleanarchitecture/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams(
      {required this.email, required this.password, required this.name});
}
