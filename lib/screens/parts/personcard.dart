import 'package:flutter/material.dart';
import 'package:imageCollector/services/storage_services.dart';

class PersonCard extends StatelessWidget {
  final String personName, personId;
  final Function personFunc;
  const PersonCard({Key key, this.personName, this.personId, this.personFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    StorageService storage = StorageService(personId);
    return FutureBuilder<Object>(
        future: storage.list1Image(),
        builder: (context, snapshot) {
          return Card(
            color: Colors.white70,
            //padding: EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Image.network(
                    snapshot.data.toString(),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  personName,
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  personId,
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          );
        });
  }
}
