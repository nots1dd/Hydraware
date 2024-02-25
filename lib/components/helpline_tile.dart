import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class HelpLineTile extends StatelessWidget {
  final phoneNumber;
  const HelpLineTile({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Card(
            child: ListTile(
            title: Text('Helpline Number'),
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