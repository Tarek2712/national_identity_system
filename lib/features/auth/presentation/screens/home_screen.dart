import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../domain/entities/citizen_entity.dart';

class HomeScreen extends StatelessWidget {
  final CitizenEntity citizen;

  const HomeScreen({super.key, required this.citizen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المنظومة القومية الموحدة للهوية'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // بطاقة الهوية الرقمية
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0A192F),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'بطاقة الهوية الرقمية المعتمدة',
                    style: TextStyle(color: Color(0xFFD4AF37), fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    citizen.fullName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'الرقم القومي: ${citizen.nationalId}',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  // QR Code الخاص بالمواطن
                  // QR Code الديناميكي المشفر الخاص بالمواطن
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12), // حواف ناعمة تليق بالكارت
                    ),
                    child: QrImageView(
                      // دمج وتشفير البيانات (رقم قومي + معرف ذكي + فصيلة الدم)
                      data: "EGY-BIO|${citizen.nationalId}|${citizen.smartAltId}|${citizen.bloodType}",
                      version: QrVersions.auto,
                      size: 160.0, // كبرناه سنة بسيطة عشان التفاصيل
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF0A192F), // خلينا لونه كحلي سيادي نفس لون الكارت بدل الأسود
                      errorCorrectionLevel: QrErrorCorrectLevel.H, // أعلى مستوى تحمل للخدوش عشان يتقري دايماً
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'المعرف الذكي: ${citizen.smartAltId}',
                    style: const TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // تفاصيل السجل الطبي الوراثي والدم
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    title: 'فصيلة الدم',
                    value: citizen.bloodType,
                    icon: Icons.bloodtype,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInfoCard(
                    title: 'حالة الهوية',
                    value: citizen.status,
                    icon: Icons.verified_user,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String value, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF0A192F), size: 32),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A192F),
            ),
          ),
        ],
      ),
    );
  }
}