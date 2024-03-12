import 'package:crud_in_api/add_details.dart';
import 'package:crud_in_api/myapi.dart';
import 'package:flutter/material.dart';

class HomePageApi extends StatefulWidget {
  @override
  State<HomePageApi> createState() => _HomePageApiState();
}

class _HomePageApiState extends State<HomePageApi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text("API DEMO"),
        actions: [
          InkWell(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return AddDetails(null);
                },
              )).then((value) {
                if (value == true) {
                  setState(() {
                    MyApi().getDetails();
                  });
                }
              });
            },
            child: Container(
              child: Icon(Icons.add),
              margin: EdgeInsets.only(right: 10),
            ),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 15,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              snapshot.data![index]["StuName"].toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            child: Image.network(
                              snapshot.data![index]["StuHobby"].toString(),
                            ),
                          ),
                          Container(
                            child: TextButton(
                              child: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                MyApi()
                                    .deleteDetails(snapshot.data![index]["id"])
                                    .then(
                                  (value) {
                                    setState(() {});
                                  },
                                );
                              },
                            ),
                          ),
                          Container(
                            child: TextButton(
                              child: Icon(Icons.edit),
                              onPressed: () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return AddDetails(snapshot.data![index]);
                                  },
                                )).then((value) {
                                  setState(() {
                                    MyApi().getDetails();
                                  });
                                },);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: MyApi().getDetails(),
        ),
      ),
    ));
  }
}
