import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
}

Future<FilePickerResult?> pickImage() async {
  final image = FilePicker.platform.pickFiles(type: FileType.image);
  return image;
}
