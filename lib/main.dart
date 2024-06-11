import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meoscleanarchitecture/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:meoscleanarchitecture/core/theme/theme.dart';
import 'package:meoscleanarchitecture/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:meoscleanarchitecture/features/blog/presentation/pages/blog_page.dart';
import 'package:meoscleanarchitecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:meoscleanarchitecture/features/auth/presentation/pages/login_page.dart';
import 'package:meoscleanarchitecture/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => sl<AppUserCubit>()),
      BlocProvider(create: (_) => sl<AuthBloc>()),
      BlocProvider(create: (_) => sl<BlogBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(AuthCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const BlogPage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
