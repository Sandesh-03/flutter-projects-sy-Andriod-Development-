// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:flutter/material.dart';

import '../helpers/sql_helper.dart';
import '../model/user_model.dart';
import '../widget/update_info.dart';
import 'addUser.dart';

class AllData extends StatefulWidget {
  const AllData({Key? key}) : super(key: key);

  @override
  State<AllData> createState() => _AllDataState();
}

class _AllDataState extends State<AllData> {
  bool _isLoading = true;

  void _getAllUsers() async {
    final data = await SQLHelper.getItems();
    setState(() {
      UserModel.allUsers = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllUsers();
  }

  Future<void> _addUser() async {
    await SQLHelper.createItem(
        UserModel.name.toString(), UserModel.age.toString());
    _getAllUsers();
  }

  Future<void> _updateUser(int id) async {
    await SQLHelper.updateItem(
        id, UserModel.name.toString(), UserModel.age.toString());
    _getAllUsers();
  }

  void _deleteUser(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.cyanAccent,
        content: Text(
          'Successfully deleted a user',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
    _getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    for (int i = 0; i < UserModel.allUsers.length; i++) {
      print("id $i ${UserModel.allUsers[i]["id"]}");
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AddUser(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          "All Users",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.redAccent.withOpacity(0.4),
                  Colors.blueAccent.withOpacity(0.4),
                ]
            )
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: UserModel.allUsers.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      if (index == 0) SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          child: ListTile(
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                          ),
                                          child:
                                          UpdateInfoBottomSheet(index: index),
                                        ),
                                      );
                                    },
                                  ); },
                                    icon: Icon(Icons.edit),
                                    iconSize: 30,
                                  ),
                                  IconButton(onPressed: (){
                                    _deleteUser(UserModel.allUsers[index]["id"]);
                                  }, icon: Icon(
                                    Icons.delete
                                  ),
                                    iconSize: 30,

                                  )
                                ],
                              ),
                            ),
                            leading: Icon(
                              Icons.person,
                              size: 35,
                            ),
                            onLongPress: () {
                              _deleteUser(UserModel.allUsers[index]['id']);
                            },
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  UserModel.allUsers[index]['name'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              " ${UserModel.allUsers[index]['age']}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Divider(color: Colors.white38),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
