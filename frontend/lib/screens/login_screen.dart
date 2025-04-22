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

  bool viewPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(64.0),
          child: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                autofocus: true,
                controller: controller['email'],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  errorText: error['email'],
                  labelText: 'Email',
                ),
                onChanged: (value) {
                  setState(() {
                    error['email'] = null;
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
    );
  }

  void login() async {
    final attributes = ['email', 'password'];

    for (var attribute in attributes) {
      if (controller[attribute]!.text.isEmpty) {
        setState(() {
          error[attribute] = 'Campo requerido';
        });
        return;
      }
    }

    if (!controller['email']!.text.contains('@') ||
        !controller['email']!.text.contains('.')) {
      final int atIndex = controller['email']!.text.indexOf('@');
      final int dotIndex = controller['email']!.text.lastIndexOf('.');
      if (atIndex < 1 ||
          dotIndex < atIndex + 2 ||
          dotIndex == controller['email']!.text.length - 1) {
        setState(() {
          error['email'] = 'Inválido';
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

    User user = User(
      email: controller['email']!.text,
      password: controller['password']!.text,
    );

    try {
      user = await UserService.login(user);
      resetController();
      resetError();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(
            user: user,
          ),
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
