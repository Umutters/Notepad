import 'package:flutter/material.dart';

class NotesTextButton extends StatelessWidget {
  const NotesTextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text('İptal'),
    );
  }
}