import 'package:flutter/material.dart';

import '../../../app.dart';
import '../../home/presentation/app_shell.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _createAccount = false;

  void _enterApp() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const AppShell()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF10264A), AppColors.navy, Color(0xFF0D1C36)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.article_outlined,
                        size: 38,
                        color: AppColors.navy,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Vehicle Passport',
                      style: TextStyle(
                        fontFamily: 'serif',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'The Digital Identity of Your Vehicle',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .65),
                      ),
                    ),
                    const SizedBox(height: 36),
                    Card(
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              _createAccount
                                  ? 'Create Account'
                                  : 'Welcome back',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.ink,
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (_createAccount)
                              const _Field(
                                label: 'FULL NAME',
                                hint: 'Kasun Perera',
                              ),
                            const _Field(
                              label: 'EMAIL ADDRESS',
                              hint: 'you@example.com',
                            ),
                            const _Field(
                              label: 'PASSWORD',
                              hint: '........',
                              obscure: true,
                            ),
                            if (!_createAccount)
                              const Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    color: AppColors.navy,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 20),
                            FilledButton(
                              onPressed: _enterApp,
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.navy,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                              child: Text(
                                _createAccount ? 'Create Account' : 'Sign In',
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 18),
                              child: Row(
                                children: [
                                  Expanded(child: Divider()),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text(
                                      'or continue with',
                                      style: TextStyle(color: AppColors.muted),
                                    ),
                                  ),
                                  Expanded(child: Divider()),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: _enterApp,
                                    icon: const Icon(
                                      Icons.g_mobiledata,
                                      color: Colors.red,
                                      size: 24,
                                    ),
                                    label: const Text('Google'),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: _enterApp,
                                    icon: const Icon(Icons.apple),
                                    label: const Text('Apple'),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () => setState(
                                () => _createAccount = !_createAccount,
                              ),
                              child: Text(
                                _createAccount
                                    ? 'Already have an account? Sign In'
                                    : "Don't have an account? Create Account",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.hint, this.obscure = false});
  final String label;
  final String hint;
  final bool obscure;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
            color: AppColors.muted,
          ),
        ),
        const SizedBox(height: 7),
        TextField(
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: AppColors.mist,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    ),
  );
}
