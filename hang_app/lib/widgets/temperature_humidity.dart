import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TemperatureHumidity extends StatefulWidget {
  const TemperatureHumidity({super.key});

  @override
  State<TemperatureHumidity> createState() => _TemperatureHumidityState();
}

class _TemperatureHumidityState extends State<TemperatureHumidity> {
  String temperature = "--"; // 默认温度显示
  String humidity = "--"; // 默认湿度显示
  bool isLoading = true; // 是否正在加载数据

  // OpenWeather API 配置
  final String apiKey = "50d9b03ae4a838a13af0332901fee61c"; // 替换为您的 API Key
  final String city = "Guangdong"; // 替换为目标城市名称

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    try {
      final url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          temperature = data['main']['temp'].toString(); // 获取温度
          humidity = data['main']['humidity'].toString(); // 获取湿度
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load weather data");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('获取天气数据失败：$e')),
      );
    }
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
          color: Colors.blue.shade50,
        ),
        child: isLoading
            ? Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.thermostat, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  '温度：$temperature ℃',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.water_drop, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  '湿度：$humidity %',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
