import 'package:flutter/material.dart';

class SettingSection extends StatelessWidget {
  const SettingSection({Key? key, required this.items}) : super(key: key);

  final Map<String, dynamic> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            items['title'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Divider(
            height: 10,
            color: Colors.grey[700],
          ),
          for (var item in items['items'])
            item['hasSwitch']
                ? Column(
                    children: [
                      SwitchListTile(
                        value: true, // always true by default
                        onChanged: (value) {},
                        title: Text(item['title']),
                        subtitle: item['subtitle'].toString().isEmpty ? null : Text(item['subtitle']),
                      ),
                      const Divider(),
                    ],
                  )
                : Column(
                    children: [
                      ListTile(
                        enabled: item['isEnabled'],
                        onTap: () {},
                        title: const Text('Language'),
                        subtitle: item['subtitle'].toString().isEmpty ? null : Text(item['subtitle']),
                      ),
                      const Divider(),
                    ],
                  ),
        ],
      ),
    );
  }
}
