import 'package:crud_in_api/myapi.dart';
import 'package:flutter/material.dart';

class AddDetails extends StatefulWidget {
  Map<String, Object?>? map;

  AddDetails(map) {
    this.map = map;
  }

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  var nameController = TextEditingController();
  var imageController = TextEditingController();

  void initState() {
    super.initState();
    nameController.text =
    widget.map == null ? '' : widget.map!["StuName"].toString();
    imageController.text =
    widget.map == null ? '' : widget.map!["StuHobby"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                icon: Icon(Icons.person_rounded),
                hintText: "Enter user Name:",
              ),
            ),
          ),
          Container(
            child: TextFormField(
              controller: imageController,
              decoration: InputDecoration(
                icon: Icon(Icons.image),
                hintText: "Enter image URL:",
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: ()  {
                if (widget.map == null) {
                   insertDetails();
                  Navigator.of(context).pop(true);
                } else {
                   updateDetails(widget.map!["id"].toString());
                  Navigator.of(context).pop(true);
                }
              },
              child: Text(
                "SUBMIT",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> insertDetails() async {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['StuName'] = nameController.text;
    map['StuHobby'] = imageController.text; // Assuming StuHobby is a URL or encoded bytes

    var res = await MyApi().insertDetails(map);
  }

  Future<void> updateDetails(String id) async {
    try{
      Map<String, dynamic> map = Map<String, dynamic>();
      map['StuName'] = nameController.text;
      map['StuHobby'] = imageController.text; // Assuming StuHobby is a URL or encoded bytes

      var res = await MyApi().updateDetails(map, id);
    }catch(error){
      print("$error");
    }

  }
}
