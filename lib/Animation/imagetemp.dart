import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

File? selectedImage;
final store = FirebaseStorage.instance.ref().child("Worker images");
String url = "";

class profileWorker extends StatefulWidget {
  const profileWorker({super.key});

  @override
  State<profileWorker> createState() => _profileWorkerState();
}

class _profileWorkerState extends State<profileWorker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                _pickImageFromGallery();
              },
              child: Text('Pick Image from Gallery'),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: selectedImage != null
                    ? Image.file(selectedImage!)
                    : Text("no file"),
              ),
            ),
            CircleAvatar(backgroundImage: NetworkImage(url)),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // Handle the picked image (e.g., display it, save it, or upload it)
      setState(() {
        selectedImage = File(pickedImage.path);
      });
      print(selectedImage);
      if (selectedImage == null)
        return;
      else {
        Reference fileChild = await store.child("1");
        await fileChild.putFile(selectedImage!);

        url = await fileChild.getDownloadURL();
        print("url" + url);
      }
    } else {
      print("no image selected");
      // User canceled the image selection
    }
  }
}
