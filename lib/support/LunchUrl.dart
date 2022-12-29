
import 'package:url_launcher/url_launcher.dart';

class LunchUrl{





  // Future<void> openMap(double latitude, double longitude) async {
  //   String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  //
  //   if (await canLaunch(googleUrl)) {
  //     await launch(googleUrl);
  //   } else {
  //     throw 'Could not open the map.';
  //   }
  // }
  Future<void> openAnyUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }


  Future<void> openMap(String latitude, String longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    print(googleUrl);
    if (!await launchUrl(
      Uri.parse(googleUrl),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $googleUrl';
    }
  }
  Future<void> openPdf(String path) async {
    String googleUrl = '';
    print(googleUrl);
    if (!await launchUrl(
      Uri.parse(googleUrl),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $googleUrl';
    }
  }
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

}