import 'dart:io';

import 'package:diary/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


var title = '';
var contents = '';
final ImagePicker picker = ImagePicker();
XFile? _image;


class Diary extends StatelessWidget {
  const Diary({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children:[
          Text(title+contents),
          _image == null ? Text('no image selected') : Image.file(File(_image!.path))

          ],
              
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Inputstate()),
            );
            //Navigator.pop(context);
          },
          child: const Icon(Icons.edit)
        ),
    );
  }
}

class Inputstate extends StatefulWidget {
  Inputstate({Key? key}) : super(key:key);

  @override
  Input createState() => Input();
}


class Input extends State<Inputstate> {

  @override
  Widget build(BuildContext context) {
    final title_save = TextEditingController();
    final contents_save = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
            child: Text("save"),
            onPressed: (){
            title=title_save.text;
            contents = contents_save.text;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home())
              );
            //Navigator.pop(context);
          }
          ),
          FloatingActionButton(onPressed: getImage,
            child: Icon(Icons.add_a_photo),
          )
        ]
      ),

      body: Column(
        children: <Widget>[
          TextField(
            controller: title_save,
          decoration: InputDecoration(
            hintText: "Title"
          ),
        ),

        TextField(
          controller: contents_save,
          decoration: InputDecoration(
            hintText: "contens"
          ),
        ),
        ]
      )
    );
  }
Future getImage() async{
  XFile? image = await picker.pickImage(source: ImageSource.gallery);
  _image = image;
  setState(() {
    _image = image;
  });
   }
}