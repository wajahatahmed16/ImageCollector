import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:imageCollector/loading/fireload.dart';
import 'package:imageCollector/models/user.dart';
import 'package:imageCollector/screens/parts/textfieldstyle.dart';
import 'package:imageCollector/services/database.dart';
import 'package:imageCollector/services/storage_services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class AddPerson extends StatefulWidget {
  AddPerson({Key key}) : super(key: key);

  @override
  _AddPersonState createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';
  String firstName, lastName, personId, personOccupation = "Student";
  final _formKey = GlobalKey<FormState>();
  bool loading = false, showError = false;

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 30,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#bf2ba3",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: true,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoginUser>(context);
    DatabaseService persons = DatabaseService(user.uid);

    return loading
        ? Loading()
        : Scaffold(
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Add Data",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        validator: (val) => val.length < 2
                            ? "Please Enter your First Name"
                            : null,
                        decoration: textDecorationStyle.copyWith(
                          hintText: "First Name",
                        ),
                        onChanged: (val) {
                          setState(() => firstName = val);
                        },
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        validator: (val) => val.length < 2
                            ? "Please Enter your Last Name"
                            : null,
                        decoration: textDecorationStyle.copyWith(
                          hintText: "Last Name",
                        ),
                        onChanged: (val) {
                          setState(() => lastName = val);
                        },
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        validator: (val) =>
                            val.length < 4 ? "Please Enter Proper ID" : null,
                        decoration: textDecorationStyle.copyWith(
                          hintText: "Identity",
                        ),
                        onChanged: (val) {
                          setState(() => personId = val);
                        },
                      ),
                      SizedBox(
                        height: 2,
                      ),

                      //DropDown

                      DropdownButtonFormField<String>(
                        decoration: textDecorationStyle,
                        isExpanded: true,
                        value: personOccupation,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (String newValue) {
                          setState(() {
                            personOccupation = newValue;
                          });
                        },
                        items: <String>['Student', 'Teacher', 'Admin', 'Staff']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      ///DropDown

                      //Center(child: Text('Error: $_error')),

                      Row(
                        children: [
                          RaisedButton(
                            child: Text("Pick images"),
                            onPressed: loadAssets,
                          ),
                          Text(" Select 20 Images"),
                        ],
                      ),
                      Expanded(
                        child: buildGridView(),
                      ),
                      if (showError)
                        Text(
                          _error,
                          style: TextStyle(color: Colors.red),
                        ),
                      FlatButton(
                        minWidth: double.infinity,
                        color: Color(0xff5ebecd),
                        textColor: Colors.white,
                        onPressed: () async {
                          StorageService storage = StorageService(personId);
                          var path = "";
                          bool ex_person = true;
                          if (ex_person) {
                            if (_formKey.currentState.validate() &&
                                images.length > 1) {
                              setState(() {
                                loading = true;
                              });
                              //Uploading Images!!!
                              for (var i = 0; i < images.length; i++) {
                                path =
                                    await FlutterAbsolutePath.getAbsolutePath(
                                        images[i].identifier);
                                await storage.saveImage(path);
                              }
                              //Updating Database
                              await persons.addPerson(firstName, lastName,
                                  personId, personOccupation, images.length);
                              setState(() {
                                loading = false;
                              });
                              Navigator.pop(context);
                            } else {
                              _error = "Fill in Form Properly.";
                              setState(() {
                                showError = true;
                              });
                            }
                          } else {
                            _error =
                                " Person with Id:${personId} already Exists !!!";
                            setState(() {
                              showError = true;
                            });
                          }
                        },
                        child: Text("Add Person"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
