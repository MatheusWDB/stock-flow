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
    'username': TextEditingController(),
    'password': TextEditingController(),
  };
  Map<String, String?> error = {
    'username': null,
    'password': null,
  };

  bool viewPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(64.0),
                child: Column(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      autofocus: true,
                      controller: controller['username'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        errorText: error['username'],
                        labelText: 'Email',
                      ),
                      onChanged: (value) {
                        setState(() {
                          error['username'] = null;
                        });
                      },
                    ),
                    TextField(
                      autocorrect: false,
                      controller: controller['password'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        errorText: error['password'],
                        labelText: 'Senha',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              viewPassword = !viewPassword;
                            });
                          },
                          icon: Icon(
                            viewPassword == true
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      obscureText: !viewPassword,
                      obscuringCharacter: '*',
                      onChanged: (value) {
                        setState(() {
                          error['password'] = null;
                        });
                      },
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    final attributes = ['username', 'password'];

    for (var attribute in attributes) {
      if (controller[attribute]!.text.isEmpty) {
        setState(() {
          error[attribute] = 'Campo requerido';
        });
        return;
      }
    }

    if (!controller['username']!.text.contains('@') ||
        !controller['username']!.text.contains('.')) {
      final int atIndex = controller['username']!.text.indexOf('@');
      final int dotIndex = controller['username']!.text.lastIndexOf('.');
      if (atIndex < 1 ||
          dotIndex < atIndex + 2 ||
          dotIndex == controller['username']!.text.length - 1) {
        setState(() {
          error['username'] = 'Inválido';
        });
        return;
      }
    }

    if (controller['password']!.text.length < 8) {
      setState(() {
        error['password'] = 'A senha tem no mínimo 8 caracteres';
      });
      return;
    }

    final User user = User(
      username: controller['username']!.text,
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
      controller['username']?.clear();
      controller['password']?.clear();
    });
  }

  void resetError() {
    setState(() {
      error['username'] = null;
      error['password'] = null;
    });
  }
}
