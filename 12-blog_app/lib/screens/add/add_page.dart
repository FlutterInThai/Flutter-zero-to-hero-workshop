import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  String _title;
  String _content;
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: _image == null
                      ? Text('No image selected.')
                      : Image.file(
                          _image,
                          height: 200,
                        ),
                  onTap: getImage,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'หัวเรื่อง',
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) => _title = value,
                  style: TextStyle(fontSize: 20.0),
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'เนื้อหา',
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) => _content = value,
                ),
                RaisedButton(
                  onPressed: () async {
                    final form = _formKey.currentState;
                    form.save();
                    String url =
                        await _uploadFile(_image, Timestamp.now().toString());
                    await Firestore.instance.collection('posts').add({
                      'title': _title,
                      'content': _content,
                      'image_url': url
                    });

                    Navigator.pop(context);
                  },
                  child: Text('บันทึก'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<String> _uploadFile(File file, String filename) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("images/$filename");
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
    return url;
  }
}
