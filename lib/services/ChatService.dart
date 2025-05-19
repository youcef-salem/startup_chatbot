
import 'package:dialog_flowtter/dialog_flowtter.dart';

class ChatService {
  DialogFlowtter? dialogFlowtter;

  // Initialize the service
  Future<void> initialize() async {
    try {
      dialogFlowtter = await DialogFlowtter.fromFile(
         path: 'assets/newagent-fske-c901e1732431.json',
        projectId:  'newagent-fske'
      
      );
    } catch (e) {
      print('Error initializing Dialogflow: $e');
    }
  }
  // Add your Dialogflow credentials JSON file to the assets folder
  // and update pubspec.yaml to include it:
  // assets:
  //   - assets/dialog_flow_auth.json
  // Send message to Dialogflow and get response
  Future<String> sendMessage(String message) async {
    if (dialogFlowtter == null) {
      await initialize();
    }

    try {
      DetectIntentResponse response = await dialogFlowtter!.detectIntent(
        queryInput: QueryInput(text: TextInput(text: message)),
      );

      if (response.message == null) return "j ai pas de reponse";

      return response.message?.text?.text?[0] ?? "il ya pas de reponse";
    } catch (e) {
      print('Error de l envoi de  message: $e');
      return "'Error de commpredre le   message";
    }
  }

  // Dispose resources
  void dispose() {
    dialogFlowtter?.dispose();
  }
}