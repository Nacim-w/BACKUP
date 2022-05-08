/* import 'dart:io';
import 'package:desktop/model/model_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DataPage extends StatefulWidget {
  final Data data;

  DataPage({this.data}); // constructor/*  */

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  // to define variables ///
  final _matriculeController = TextEditingController();
  final _tagIdController = TextEditingController();

  final _matriculeFocus = FocusNode();
  final _tagIdFocus = FocusNode();

  bool _userEdited = false;

  Data _editData;

  @override
  void initState() {
    super.initState();

    if (widget.data == null) {
      _editData = Data();
    } else {
      _editData = Data.fromMap(widget.data.toMap());
      _matriculeController.text = _editData.matricule;
      _tagIdController.text = _editData.tagId;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ui of data page
    return WillPopScope(

      // to call _requestPop function
        onWillPop: _requestPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text(_editData.matricule ?? "New Data"),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              // code to save data
              onPressed: () {
                if (_editData.matricule.isNotEmpty && _editData.matricule != null) {
                  Navigator.pop(context, _editData);
                } else if (_editData.tagId.isNotEmpty &&
                    _editData.tagId != null) {
                  Navigator.pop(context, _editData);
                } else {
                  FocusScope.of(context).requestFocus(_matriculeFocus);

                  FocusScope.of(context).requestFocus(_tagIdFocus);
                }
              },
              child: Icon(Icons.save),
              backgroundColor: Colors.blue,
            ),

            // ui of matricule textfield, tagId textfield and image
            body: SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    // ui of image
                    child: Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: _editData.img != null
                                ? FileImage(File(_editData.img))
                                : AssetImage("assets/images/user-default.png"),
                            fit: BoxFit.cover),
                      ),
                    ),

                    // code to pick image from gallery
                    onTap: () {
                      ImagePicker.pickImage(source: ImageSource.gallery)
                          .then((file) {
                        if (file == null) return;
                        setState(() {
                          _editData.img = file.path;
                        });
                      });
                    },
                  ),

                  // ui of matricule textfield
                  TextField(
                    controller: _matriculeController,
                    focusNode: _matriculeFocus,
                    decoration: InputDecoration(labelText: "Matricule"),
                    onChanged: (text) {
                      _userEdited = true;
                      setState(() {
                        _editData.matricule = text;
                      });
                    },
                  ),

                  // ui of tagId textfield
                  TextField(
                    controller: _tagIdController,
                    focusNode: _tagIdFocus,
                    decoration: InputDecoration(labelText: "Tag ID"),
                    onChanged: (text) {
                      _userEdited = true;
                      _editData.tagId = text;
                    },
                  ),
                ],
              ),
            )));
  }

  // function to show alert dialog
  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog();
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
 */