// lib/main.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'widgets/date_display.dart';
import 'widgets/fan_show.dart';
import 'widgets/drying_rack.dart';
import 'widgets/temperature_humidity.dart';
import 'services/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Controller',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: const IoTControlPage(),
    );
  }
}

class IoTControlPage extends StatefulWidget {
  const IoTControlPage({super.key});
  @override
  _IoTControlPageState createState() => _IoTControlPageState();
}

class _IoTControlPageState extends State<IoTControlPage> {
  bool isFanOn = false;
  bool isRackOn = false;
  String updateTime = "未知";
  Timer? _statusTimer;

  @override
  void initState() {
    super.initState();
    _fetchStatus();
    // 每2秒自动刷新一次状态
    _statusTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _fetchStatus();
    });
  }

  Future<void> _fetchStatus() async {
    try {
      final service = IoTService();
      final status = await service.fetchStatus();
      setState(() {
        isFanOn = status['fan_status'];
        isRackOn = status['clothes_rack_status'];
        updateTime = status['update_time'];
      });
    } catch (e) {
      // 出错时可在这里处理提示，或记录日志
    }
  }

  @override
  void dispose() {
    _statusTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40), // 为状态栏留出空间
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 传入刷新回调函数
                  DateDisplay(onStatusRefresh: _fetchStatus),
                  const Expanded(child: SizedBox()),
                ],
              ),
              const SizedBox(height: 32),
              // 温湿度模块
              const TemperatureHumidity(),
              const SizedBox(height: 32),
              // 风扇和晾衣杆状态展示（静态卡片）
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: FanShow(isFanOn: isFanOn)),
                  const SizedBox(width: 16),
                  Expanded(child: DryingRack(isRackOn: isRackOn)),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                "最后更新时间: $updateTime",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
