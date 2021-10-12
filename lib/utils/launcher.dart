import 'package:url_launcher/url_launcher.dart';

class Launcher {
  static launchWP(String phone) async {
    var whatsappUrl = "whatsapp://send?phone=52$phone";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        // ignore: avoid_print
        : print(
            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }

  static launchCall(String phone) async {
    var url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}