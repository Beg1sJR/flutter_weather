import 'package:flutter/material.dart';

class DetailsContainer extends StatelessWidget {
  const DetailsContainer({
    super.key,
    required this.text,
    required this.info,
    required this.icon,
    this.bottomText,
  });

  final String text;
  final String info;
  final String? bottomText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[800]?.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(icon, color: Colors.white70),
            title: Text(
              text,
              style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white70),
            ),
          ),
          Text(
            info,
            style: theme.textTheme.titleLarge!.copyWith(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
          Text(
            bottomText ?? '',
            style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
