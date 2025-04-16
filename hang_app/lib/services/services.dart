// lib/services/services.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class IoTService {
  final String statusUrl = 'http://159.75.158.12:5000/status';

  /// 获取后端当前状态，返回包含 fan_status（风扇）和 clothes_rack_status（晾衣杆）的 Map
  Future<Map<String, dynamic>> fetchStatus() async {
    final response = await http.get(Uri.parse(statusUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('获取状态失败，状态码：${response.statusCode}');
    }
  }
}
