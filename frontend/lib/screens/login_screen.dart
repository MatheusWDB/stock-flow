import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/screens/dashboard_screen.dart';
import 'package:frontend/screens/register_screen.dart';
import 'package:frontend/services/user_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map<String, TextEditingController> controller = {
    'email': TextEditingController(),
    'password': TextEditingController(),
  };
  Map<String, String?> error = {
    'email': null,
    'password': null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                children: [
                  TextField(
                    controller: controller['email'],
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: error['email'],
                    ),
                    onChanged: (value) {},
                  ),
                  TextField(
                    autocorrect: false,
                    controller: controller['password'],
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      errorText: error['password'],
                    ),
                    obscureText: true,
                    obscuringCharacter: '*',
                    onChanged: (value) {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => login(),
                        child: const Text('Entrar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          resetController();
                          resetError();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text('Cadastrar'),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Esqueci a senha'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    final User user = User(
      email: controller['email']!.text,
      password: controller['password']!.text,
    );

    try {
      await UserService.login(user);
      resetController();
      resetError();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );
    } catch (e) {
      debugPrint('Erro ao logar: $e');
    }
  }

  void resetController() {
    setState(() {
      controller['email']?.clear();
      controller['password']?.clear();
    });
  }

  void resetError() {
    setState(() {
      error['email'] = null;
      error['password'] = null;
    });
  }
}
