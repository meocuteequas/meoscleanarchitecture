import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meoscleanarchitecture/core/theme/app_pallete.dart';
import 'package:meoscleanarchitecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:meoscleanarchitecture/features/auth/presentation/pages/login_page.dart';
import 'package:meoscleanarchitecture/features/auth/presentation/widgets/auth_field.dart';
import 'package:meoscleanarchitecture/features/auth/presentation/widgets/auth_gradient_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign up.",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              AuthField(
                hintText: "Name",
                controller: nameController,
              ),
              const SizedBox(height: 15),
              AuthField(
                hintText: "Email",
                controller: emailController,
              ),
              const SizedBox(height: 15),
              AuthField(
                hintText: "Password",
                isObscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 20),
              AuthGradientButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          AuthSignUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            name: nameController.text.trim(),
                          ),
                        );
                  }
                },
                caption: "Sign Up",
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.push(context, LoginPage.route()),
                child: RichText(
                  text: TextSpan(
                      text: "Already have an account? ",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: "Sign In",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
