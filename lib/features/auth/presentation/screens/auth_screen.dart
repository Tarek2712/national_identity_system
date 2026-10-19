import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';
import '../../../civil_registry/presentation/screens/civil_registry_dashboard.dart'; // تأكد أن هذا المسار صحيح في مشروعك

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shield, size: 80, color: Color(0xFF0D1B2A)),
                const SizedBox(height: 20),
                const Text('NID Nexus', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0D1B2A), fontFamily: 'Cairo')),
                const Text('تسجيل الدخول القومي', style: TextStyle(fontSize: 16, color: Colors.grey, fontFamily: 'Cairo')),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'البريد الإلكتروني', prefixIcon: Icon(Icons.email), border: OutlineInputBorder()),
                  validator: (value) => value!.isEmpty ? 'مطلوب' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'كلمة المرور', prefixIcon: Icon(Icons.lock), border: OutlineInputBorder()),
                  validator: (value) => value!.isEmpty ? 'مطلوب' : null,
                ),
                const SizedBox(height: 30),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      if (state.department == 'civil') {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const CivilRegistryDashboard()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('شاشة قطاع ${state.department} غير مبرمجة بعد', style: const TextStyle(fontFamily: 'Cairo'))));
                      }
                    } else if (state is AuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message, style: const TextStyle(fontFamily: 'Cairo')), backgroundColor: Colors.redAccent));
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) return const CircularProgressIndicator();
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D1B2A)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().login(_emailController.text.trim(), _passwordController.text.trim());
                          }
                        },
                        child: const Text('دخول', style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Cairo')),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
