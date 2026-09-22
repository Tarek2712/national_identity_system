import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // بيانات افتراضية مسجلة مسبقاً للتجربة السريعة
  final TextEditingController _idController =
  TextEditingController(text: '30201011234567');
  final TextEditingController _passwordController =
  TextEditingController(text: 'National@2026');
  bool _obscurePassword = true;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(citizen: state.citizen),
                  ),
                );
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: const Color(0xFFE53935),
                  ),
                );
              }
            },
            builder: (context, state) {
              final bool isLoading = state is AuthLoading;

              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // شعار المنظومة الذكية
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A192F),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0A192F).withOpacity(0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.security_rounded,
                          size: 48,
                          color: Color(0xFFD4AF37), // اللون الذهبي السيادي
                        ),
                      ),
                      const SizedBox(height: 20),

                      const Text(
                        'المنظومة القومية الموحدة للهوية',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0A192F),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'بوابة تسجيل الدخول الآمن للكوادر والمواطنين',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: Colors.blueGrey),
                      ),
                      const SizedBox(height: 32),

                      // حقل الرقم القومي / اسم المستخدم
                      TextField(
                        controller: _idController,
                        decoration: InputDecoration(
                          labelText: 'الرقم القومي / اسم المستخدم',
                          prefixIcon: const Icon(Icons.badge_outlined),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // حقل كلمة المرور
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'كلمة المرور',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // زرار تسجيل الدخول المباشر
                      ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                          context.read<AuthCubit>().loginWithCredentials(
                            nationalId: _idController.text.trim(),
                            password: _passwordController.text.trim(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A192F),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // فاصل بصري
                      Row(
                        children: const [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'أو المصادقة البيومترية المباشرة',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // زرار بصمة الوجه (Face ID)
                      OutlinedButton.icon(
                        onPressed: isLoading
                            ? null
                            : () {
                          context.read<AuthCubit>().loginWithFaceId();
                        },
                        icon: const Icon(
                          Icons.face_retouching_natural_rounded,
                          color: Color(0xFF1E88E5),
                          size: 26,
                        ),
                        label: const Text(
                          'تسجيل الدخول عبر بصمة الوجه (Face ID)',
                          style: TextStyle(
                            color: Color(0xFF0A192F),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: Color(0xFF1E88E5), width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}