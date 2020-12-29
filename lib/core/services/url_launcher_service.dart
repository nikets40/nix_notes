

import 'package:url_launcher/url_launcher.dart';

class UrlService{
  static UrlService instance = UrlService();

  openTermsAndConditions(){
    _launchURL("https://sites.google.com/view/stikynotestermsandservices");
  }
  openPrivacyPolicy(){
    _launchURL("https://sites.google.com/view/stikynotesprivacypolicy");
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  
}