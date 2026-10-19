import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/citizen_entity.dart';
import '../cubit/auth_cubit.dart';
import 'auth_screen.dart';

import 'package:national_identity_system/core/presentation/widgets/gradient_background.dart';
import 'package:national_identity_system/features/medical_record/presentation/screens/medical_record_screen.dart';
import 'package:national_identity_system/features/medical_record/presentation/cubit/medical_record_cubit.dart';
import 'package:national_identity_system/features/family_tree/presentation/screens/family_tree_screen.dart';
import 'package:national_identity_system/features/emergency/presentation/screens/emergency_screen.dart';
import 'package:national_identity_system/features/audit_logs/presentation/screens/audit_logs_screen.dart';

class HomeScreen extends StatelessWidget {
  final CitizenEntity citizen;

  const HomeScreen({super.key, required this.citizen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'المنظومة القومية للهوية',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_active, color: Colors.white), onPressed: () {}),
          IconButton(
            tooltip: 'تسجيل خروج',
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(create: (context) => sl<AuthCubit>(), child: const AuthScreen()),
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.shield, size: 60, color: Colors.white),
                const SizedBox(height: 10),
                Text('مرحباً بك،', style: TextStyle(fontSize: 16, color: Colors.white70, fontFamily: 'Cairo'), textAlign: TextAlign.center),
                Text(citizen.fullName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Cairo'), textAlign: TextAlign.center),
                const SizedBox(height: 24),
                _buildDigitalIdentityCard(citizen),
                const SizedBox(height: 32),
                const Text('الخدمات المرتبطة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Cairo')),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: [
                    _buildServiceCard(context, title: 'السجل الطبي الوراثي', icon: Icons.health_and_safety, onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => sl<MedicalRecordCubit>(), child: MedicalRecordScreen(citizenId: citizen.id))));
                    }),
                    _buildServiceCard(context, title: 'شجرة العائلة', icon: Icons.family_restroom, onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FamilyTreeScreen(citizenId: citizen.id)));
                    }),
                    _buildServiceCard(context, title: 'سجل الصلاحيات', icon: Icons.security, onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AuditLogsScreen(citizenId: citizen.id))); }),
                    _buildServiceCard(context, title: 'نداء طوارئ', icon: Icons.emergency, isEmergency: true, onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => EmergencyScreen(citizenId: citizen.id))); }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDigitalIdentityCard(CitizenEntity citizen) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.fingerprint, color: Colors.cyanAccent, size: 40),
              const Text('هوية رقمية موثقة', style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
            ],
          ),
          const Divider(color: Colors.white24, height: 30, thickness: 1),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
                child: QrImageView(
                  data: "EGY-BIO|${citizen.nationalId}|${citizen.smartAltId}|${citizen.bloodType}",
                  version: QrVersions.auto,
                  size: 110.0,
                  backgroundColor: Colors.white,
                  errorCorrectionLevel: QrErrorCorrectLevel.H,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('الرقم القومي', citizen.nationalId),
                    const SizedBox(height: 8),
                    _buildInfoRow('المعرف الذكي', citizen.smartAltId),
                    const SizedBox(height: 8),
                    _buildInfoRow('فصيلة الدم', citizen.bloodType),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12, fontFamily: 'Cairo')),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
      ],
    );
  }

  Widget _buildServiceCard(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap, bool isEmergency = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: isEmergency ? Colors.redAccent.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isEmergency ? Colors.redAccent : Colors.white.withValues(alpha: 0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: isEmergency ? Colors.redAccent : Colors.white),
            const SizedBox(height: 12),
            Text(title, textAlign: TextAlign.center, style: TextStyle(color: isEmergency ? Colors.redAccent : Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
          ],
        ),
      ),
    );
  }
}
