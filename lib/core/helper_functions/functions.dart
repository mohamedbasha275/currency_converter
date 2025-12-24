// // Launch url
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
//
// Future<void> launchLink(String url) async {
//   final uri = Uri.tryParse(url);
//
//   if (uri == null) {
//     throw FormatException('Invalid URL: $url');
//   }
//
//   final launched = await launchUrl(
//     uri,
//     mode: LaunchMode.externalApplication,
//   );
//
//   if (!launched) {
//     throw 'Could not launch $url';
//   }
// }
