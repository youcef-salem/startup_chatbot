import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class Rec_service with ChangeNotifier {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool isListening = false;
  String _recognizedText = "";

  Future<bool> requestPermission() async {
    var status = await Permission.microphone.request();
    if (status.isDenied) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> initilasation() async {
    bool available = await _speech.initialize();
    return available;
  }

  void startListening(Function(String) onResult) async {
    if (!isListening) {
      await _speech.listen(
        onResult: (result) {
          _recognizedText = result.recognizedWords;
          onResult(_recognizedText); // Pass text to UI
        },
      );



      chngestate();
    }
  }

  void chngestate() {
    if (isListening) {
      isListening = false;
    } else {
      isListening = true;
    }
    notifyListeners();
    print(isListening);
  }

  void stopListening() async {
    await _speech.stop();
    chngestate();
  }

  String get recognizedText => _recognizedText;
}
