import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meoscleanarchitecture/core/theme/theme.dart';
import 'package:meoscleanarchitecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:meoscleanarchitecture/features/auth/presentation/pages/login_page.dart';
import 'package:meoscleanarchitecture/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => sl<AuthBloc>()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
