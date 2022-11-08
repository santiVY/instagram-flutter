import 'package:flutter/material.dart';
import 'package:my_app/change_notifier/login_change_notifier.dart';
import 'package:my_app/pages/navigation_page.dart';
import 'package:my_app/utils/assets.dart';
import 'package:my_app/widgets/my_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:my_app/utils/status.dart';
import 'package:my_app/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  late LoginChangeNotifier _changeNotifier;

  @override
  void initState() {
    super.initState();
    _changeNotifier = context.read<LoginChangeNotifier>();
    _passwordTextController.addListener(() {
      _changeNotifier.validatePassword(_passwordTextController.value.text);
    });

    _changeNotifier.addListener(() {
      switch (_changeNotifier.status) {
        case Status.error:
          showDialog(
              context: context,
              builder: (dContext) {
                return AlertDialog(
                  title: const Text('Iniciar Sesión'),
                  content: const Text('Usuario y contraseña fallido'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(dContext).pop();
                      },
                      child: const Text('Entendido'),
                    )
                  ],
                );
              });
          break;
        case Status.success:
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const NavigationPage()),
            (route) => false,
          );
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<LoginChangeNotifier>(
            builder: (_, value, __) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      Assets.icAppLogo,
                      height: 200,
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: _usernameTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordTextController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle: const TextStyle(fontSize: 18),
                        errorText: value.passwordError,
                      ),
                    ),
                    const SizedBox(height: 49),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 400),
                      crossFadeState: value.status.isLoading()
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: Column(
                        children: const [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                      secondChild: const SizedBox.shrink(),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 150,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: () => value.loginUser(
                            _usernameTextController.value.text,
                            _passwordTextController.value.text,
                          ),
                          child: const Text('Login'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          'Do not have an account?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
