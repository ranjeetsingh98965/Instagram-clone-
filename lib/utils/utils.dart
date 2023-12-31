import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source); // XFile -> it wraps bits of the selected file

  if(_file != null)
    {
      return await _file.readAsBytes();
    }
  print("No image selected");
}


showSnackBar(String content , BuildContext context) // showSnackBar -> it works like a 'Toast' to show message.
{
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(content)
    ),
  );
}