import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/screens/auth_screen.dart';
import 'injection_container.dart' as di;

/// Application Entry Point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://kbxhekuvovafweymydjk.supabase.co',
    anonKey: 'sb_publishable_uLtt3CMshiP7in3gPjJkWw_hrE1vjZb',
  );

  await di.initInjection();

  runApp(const NationalIdentityApp());
}

/// Root Application Widget
class NationalIdentityApp extends StatelessWidget {
  const NationalIdentityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'النظام القومي للهوية',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      supportedLocales: const [Locale('ar', 'EG')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('ar', 'EG'),

      home: const AuthScreen(),
    );
  }
}