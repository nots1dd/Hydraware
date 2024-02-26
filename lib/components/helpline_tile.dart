import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class HelpLineTile extends StatelessWidget {
  final phoneNumber;
  final String helpline;
  const HelpLineTile({super.key, required this.phoneNumber, required this.helpline});

  @override
  Widget build(BuildContext context) {
    return Card(
            child: ListTile(
            title: Text(helpline),
            subtitle: Text(phoneNumber.toString()),
            trailing: IconButton(
              icon: const Icon(Icons.call, color: Colors.blue),
              onPressed: () {
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: phoneNumber.toString(),
                );
                launchUrl(launchUri);
              }
            ),
          ),
        );
  }
}