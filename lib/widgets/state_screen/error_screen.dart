import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onCancel;
  final VoidCallback? onRetry;
  const ErrorScreen({super.key, required this.title, required this.message, this.onCancel, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.4),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  const Padding(padding: EdgeInsets.only(top: 4)),
                  Text(message),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onRetry != null) FilledButton(onPressed: onRetry, child: const Text("Retry")),
                  if (onRetry != null && onCancel != null) const Padding(padding: EdgeInsets.only(left: 8)),
                  if (onCancel != null) TextButton(onPressed: onCancel, child: const Text("Close")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
