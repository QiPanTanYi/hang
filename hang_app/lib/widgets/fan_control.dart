import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FanControl extends StatefulWidget {
  const FanControl({super.key});

  @override
  State<FanControl> createState() => _FanControlState();
}

class _FanControlState extends State<FanControl> {
  bool isFanOn = false;
  String fanStatus = "热风已关闭";

  void toggleFan() {
    setState(() {
      isFanOn = !isFanOn;
      fanStatus = isFanOn ? "热风已启动" : "热风已关闭";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: isFanOn
                ? [Color(0xFFFFD194), Color(0xFFD1913C)] // 金黄色渐变
                : [Color(0xFFF8BBD0), Color(0xFFE91E63)], // 粉红色渐变
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              fanStatus,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: toggleFan,
              icon: FaIcon(
                isFanOn ? FontAwesomeIcons.wind : FontAwesomeIcons.solidSnowflake,
                color: isFanOn ? Colors.red : Colors.green,
              ),
              label: Text(
                isFanOn ? '关' : '开',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isFanOn ? Colors.red : Colors.green,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
