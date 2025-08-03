import 'package:flutter/material.dart';

Future<void> showDeleteDialog({
  required BuildContext context,
  required VoidCallback onDelete,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Silmek İstediğinize Emin Misiniz?'),
      content: const Text('Bu işlem geri alınamaz.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('İptal'),
        ),
        TextButton(
          onPressed: () {
            onDelete();
            Navigator.of(context).pop();
          },
          child: const Text('Sil', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}


