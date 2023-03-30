import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_test/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            if (kIsWeb) {
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result != null) {
                Uint8List fileBytes = result.files.first.bytes!;
                File file = File.fromRawPath(fileBytes);
                await StoreService.uploadImage(file).then((value) {
                  log(value.toString());
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Uploaded"),
                          content: Text(
                            value.toString(),
                          ),
                        );
                      });
                });
              }
            }
          },
          child: const Text("Upload File"),
        ),
      ),
    );
  }
}
