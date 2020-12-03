import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:imageCollector/models/user.dart';
import 'package:imageCollector/screens/parts/personcard.dart';
import 'package:imageCollector/services/authentication_service.dart';
import 'package:imageCollector/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  personTest(String s) async {
    print(s);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoginUser>(context);
    DatabaseService persons = DatabaseService(user.uid);
    return StreamBuilder<QuerySnapshot>(
        stream: persons.personData,
        builder: (context, snapshot) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xff5ebecd),
              onPressed: () {
                Navigator.pushNamed(context, 'addperson');
              },
              child: Icon(Icons.person_add),
            ),
            backgroundColor: Color(0xff5ebecd),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color(0xff5ebecd),
              title: Text("IMAGE COLLECTOR"),
              actions: [
                FlatButton(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(40, 100),
                  ),
                ),
                child: GridView.count(
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  crossAxisCount: 2,
                  children: (snapshot.data != null)
                      ? snapshot.data.docs
                          .map(
                            (e) => PersonCard(
                              //personImage: Image.asset("images/avatar.png"),
                              personName:
                                  "${e.data()['first_Name']} ${e.data()['last_Name']}",
                              personId: e.data()['person_Id'],
                              personFunc: personTest,
                            ),
                          )
                          .toList()
                      : [
                          Text("No Data Found!!!"),
                        ],
                ),
              ),
            ),
          );
        });
  }
}
