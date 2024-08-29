import 'package:flutter/material.dart';

int x = 0;

class Workerhome extends StatefulWidget {
  const Workerhome({super.key});
  @override
  State<Workerhome> createState() => _UserhomeState();
}

class _UserhomeState extends State<Workerhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Profile")
        ],
        currentIndex: x,
        onTap: (value) {
          print(value);
          setState(() {
            x = value;
          });
        },
        backgroundColor: Color.fromARGB(255, 64, 99, 164),
        fixedColor: Colors.amber,
      ),
      body: Center(
        child: Text("Worker"),
      ),
    );
  }
}



//  Expanded(
//               child: Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 child: selectedImage != null
//                     ? Image.file(selectedImage!)
//                     : Text("no file"),
//               ),
//             ),
//             CircleAvatar(
//               backgroundImage: selectedImage !=null?
//                   FileImage(selectedImage!):FileImage(selectedImage!),
//             ),
