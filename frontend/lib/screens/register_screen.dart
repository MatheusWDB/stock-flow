import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/user_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Map<String, TextEditingController> controller = {
    'name': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    'confirmPassword': TextEditingController(),
  };
  Map<String, String?> error = {
    'name': null,
    'email': null,
    'password': null,
    'confirmPassword': null,
  };

  bool viewPassword = false;
  bool viewConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                controller: controller['name'],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  errorText: error['name'],
                  labelText: 'Nome',
                ),
                onChanged: (value) {
                  setState(() {
                    error['name'] = null;
                  });
                },
              ),
              TextField(
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
              TextField(
                autocorrect: false,
                controller: controller['confirmPassword'],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  errorText: error['confirmPassword'],
                  labelText: 'Confirme a senha',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        viewConfirmPassword = !viewConfirmPassword;
                      });
                    },
                    icon: Icon(
                      viewConfirmPassword == true
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                obscureText: !viewConfirmPassword,
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
                    onPressed: () => register(),
                    child: const Text('Cadastrar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      resetController();
                      resetError();
                      Navigator.pop(context);
                    },
                    child: const Text('Voltar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    final attributes = ['name', 'email', 'password', 'confirmPassword'];

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

    if (controller['password']!.text != controller['confirmPassword']!.text) {
      setState(() {
        error['password'] = 'As senha não coincidem!';
        error['confirmPassword'] = 'As senha não coincidem!';
      });
      return;
    }

    final User user = User(
      name: controller['name']!.text,
      email: controller['email']!.text,
      password: controller['password']!.text,
    );

    try {
      await UserService.createUser(user);
      resetController();
      resetError();

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      debugPrint('Erro ao cadastrar: $e');
    }
  }

  void resetController() {
    setState(() {
      controller['email']?.clear();
      controller['password']?.clear();
      controller['name']?.clear();
      controller['confirmPassword']?.clear();
    });
  }

  void resetError() {
    setState(() {
      error['name'] = null;
      error['confirmPassword'] = null;
      error['email'] = null;
      error['password'] = null;
    });
  }
}
