import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Picuploader extends StatefulWidget {
  const Picuploader({super.key});

  @override
  State<Picuploader> createState() => _PicuploaderState();
}

class _PicuploaderState extends State<Picuploader> {
  String? image;
  Future<String?> uploadimage(File path) async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    DateTime currentTime = DateTime.now();
    String timestamp = currentTime.millisecondsSinceEpoch.toString();
    firebase_storage.Reference ref = storage.ref().child('images/$timestamp');
    firebase_storage.UploadTask task = ref.putFile(path);
    await task;
    String url = await ref.getDownloadURL();
    setState(() {
      image = url;
    });
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          final PickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (PickedFile == null) {
            return;
          } else {
            File path = File(PickedFile.path);
            image= await uploadimage(path);
            setState(() {
              
            });
          }
        },
        child: image == null? Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(color: Colors.grey,),
        ):Image.network(image!)
      ),
    );
  }
}
