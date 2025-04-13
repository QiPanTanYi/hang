import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VoiceControl extends StatefulWidget {
  const VoiceControl({super.key});

  @override
  State<VoiceControl> createState() => _VoiceControlState();
}

class _VoiceControlState extends State<VoiceControl> {
  bool isRecording = false;

  void toggleRecording() {
    setState(() {
      isRecording = !isRecording;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: toggleRecording,
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: isRecording ? Colors.red : Colors.green,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isRecording ? FontAwesomeIcons.stop : FontAwesomeIcons.microphone,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }
}
