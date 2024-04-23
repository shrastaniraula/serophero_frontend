import 'package:flutter/material.dart';

enum SnackbarType { success, info, error }

class MySnackbar {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    required SnackbarType type,
  }) {
    final Color color;
    final IconData icon;

    switch (type) {
      case SnackbarType.success:
        color = Colors.green;
        icon = Icons.check_circle_outline;
        break;
      case SnackbarType.info:
        color = Color.fromARGB(255, 211, 159, 2);
        icon = Icons.info_outline;
        break;
      case SnackbarType.error:
        color = Colors.red;
        icon = Icons.remove_circle_outline_sharp;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Row(
          children: <Widget>[
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ],
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
