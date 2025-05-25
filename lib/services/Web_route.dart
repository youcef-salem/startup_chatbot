
import 'package:url_launcher/url_launcher.dart';

class WebRoute {
  Map<String, String> routes = {
    
    'contact': 'https://linktr.ee/fbstartupshall',
    'register': 'https://moulayamine.github.io/StartUpChatBot/',
    'more'  : 'https://moulayamine.github.io/intentPage/',
    
  };
 Future<void> launchWebsite(String site_name) async {
      // Close the drawer
     
      // Open the website
      final Uri _url = Uri.parse(routes[site_name] ?? 'https://linktr.ee/fbstartupshall');
      if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $_url';
        
      }
    
  }
}
