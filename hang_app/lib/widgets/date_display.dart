// lib/widgets/date_display.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class DateDisplay extends StatefulWidget {
  final VoidCallback? onStatusRefresh;
  const DateDisplay({Key? key, this.onStatusRefresh}) : super(key: key);

  @override
  _DateDisplayState createState() => _DateDisplayState();
}

class _DateDisplayState extends State<DateDisplay> {
  late Timer _timer;
  late String _dateString;
  late String _timeString;

  @override
  void initState() {
    super.initState();
    _updateDateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateDateTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateDateTime() {
    final now = DateTime.now();
    setState(() {
      _dateString = DateFormat('yyyy年MM月dd日').format(now);
      _timeString = DateFormat('HH:mm:ss').format(now);
    });
  }

  void _onRefreshPressed() {
    _updateDateTime();
    // 调用外部传入的状态刷新回调
    widget.onStatusRefresh?.call();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('状态已刷新'), duration: Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.blue),
              onPressed: _onRefreshPressed,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _dateString,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  _timeString,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.blue, letterSpacing: 1.2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
