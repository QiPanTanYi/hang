// lib/widgets/fan_show.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FanShow extends StatelessWidget {
  final bool isFanOn;
  const FanShow({super.key, required this.isFanOn});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      // 根据风扇状态选择背景色
      color: isFanOn ? Colors.orange[100] : Colors.grey[300],
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 使用 FontAwesome 图标展示风扇或制冷状态
            FaIcon(
              isFanOn ? FontAwesomeIcons.fan : FontAwesomeIcons.solidSnowflake,
              size: 50,
              color: isFanOn ? Colors.deepOrange : Colors.blueGrey,
            ),
            const SizedBox(height: 16),
            Text(
              isFanOn ? "热风已启动" : "热风已关闭",
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
