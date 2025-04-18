// lib/widgets/drying_rack.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DryingRack extends StatelessWidget {
  final bool isRackOn;
  const DryingRack({super.key, required this.isRackOn});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      // 根据状态选择浅绿色或中性灰色背景
      color: isRackOn ? Colors.lightGreen[100] : Colors.grey[300],
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_laundry_service,
              size: 50,
              color: isRackOn ? Colors.green : Colors.grey[600],
            ),
            const SizedBox(height: 16),
            Text(
              isRackOn ? "衣物晾晒中" : "衣物已收回",
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
