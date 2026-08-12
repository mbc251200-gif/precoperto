
import 'package:flutter/material.dart';
import '../repositories/auth_repository.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  bool signup = false;
  bool loading = false;

  Future<void> submit() async {
    setState(() => loading = true);
    try {
      if (signup) {
        await AuthRepository().signUp(
          email: email.text.trim(),
          password: password.text,
          name: name.text.trim(),
          type: 'consumer',
        );
      } else {
        await AuthRepository().signIn(email.text.trim(), password.text);
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
      );
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(signup ? 'Criar conta' : 'Entrar')),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        if (signup) TextField(controller: name, decoration: const InputDecoration(labelText: 'Nome')),
        TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'E-mail')),
        TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Senha')),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: loading ? null : submit,
          child: Text(loading ? 'Aguarde...' : signup ? 'Criar conta' : 'Entrar'),
        ),
        TextButton(
          onPressed: () => setState(() => signup = !signup),
          child: Text(signup ? 'Já tenho conta' : 'Criar nova conta'),
        ),
      ],
    ),
  );
}
