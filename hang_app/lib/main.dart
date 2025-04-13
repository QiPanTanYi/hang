import 'package:flutter/material.dart';
import 'widgets/date_display.dart';
import 'widgets/fan_control.dart';
import 'widgets/drying_rack.dart';
import 'widgets/temperature_humidity.dart';
import 'widgets/voice_control.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const IoTControlPage(),
    );
  }
}

class IoTControlPage extends StatelessWidget {
  const IoTControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40), // 为状态栏留出空间
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DateDisplay(), // 日期时间显示移到左边
                  Expanded(child: SizedBox()), // 右侧空白
                ],
              ),
              SizedBox(height: 32),
              // 温湿度模块 (单独一行)
              TemperatureHumidity(),
              SizedBox(height: 32),
              // 热风控制 & 晾晒衣物模块 (同行)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: FanControl()), // 热风控制
                  SizedBox(width: 16),
                  Expanded(child: DryingRack()), // 晾晒衣物
                ],
              ),
              SizedBox(height: 32),
              // 语音控制模块
              VoiceControl(),
            ],
          ),
        ),
      ),
    );
  }
}

