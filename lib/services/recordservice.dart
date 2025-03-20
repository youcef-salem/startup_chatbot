import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class Rec_service {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _recognizedText = "";

  Future<bool> requestPermission() async {
    var status = await Permission.microphone.request();
    if (status.isDenied) {
      return false;
    } else {
      return true;
    }
  }

   Future<bool> initilasation()async{
    bool available = await _speech.initialize();
    return available;
   
   }
    void startListening(Function(String) onResult) async {
    if (!_isListening) {
      await _speech.listen(onResult: (result) {
        _recognizedText = result.recognizedWords;
        onResult(_recognizedText); // Pass text to UI
      });
      _isListening = true;
    }
  }
  void stopListening() async {
    await _speech.stop();
    _isListening = false;
  }
    String get recognizedText => _recognizedText;





}
