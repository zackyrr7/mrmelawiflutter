import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmationDialog extends StatefulWidget {
  final String title;
  final String message;
  final String positiveText;
  final String negativeText;
  final void Function()? positiveAction;
  final void Function()? negativeAction;
  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.message,
    this.positiveAction,
    this.negativeAction,
    this.positiveText = "Yes",
    this.negativeText = "Cancel",
  }) : super(key: key);

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Container(
        constraints: BoxConstraints(
          minWidth: min(MediaQuery.of(context).size.width, 192),
        ),
        child: Text(widget.message),
      ),
      actions: [
        SizedBox(
          width: 92,
          child: FilledButton(
            child: Text(widget.positiveText),
            onPressed: () {
              widget.positiveAction?.call();
              if (mounted) context.pop(true);
            },
          ),
        ),
        SizedBox(
          width: 92,
          child: TextButton(
            child: Text(widget.negativeText),
            onPressed: () {
              widget.negativeAction?.call();
              if (mounted) context.pop(false);
            },
          ),
        ),
      ],
      actionsPadding: const EdgeInsets.all(8),
    );
  }
}
