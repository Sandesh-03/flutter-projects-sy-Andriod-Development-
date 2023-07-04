// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helpers/sql_helper.dart';
import '../model/user_model.dart';

class UpdateInfoBottomSheet extends StatefulWidget {
  const UpdateInfoBottomSheet({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<UpdateInfoBottomSheet> createState() => _UpdateInfoBottomSheetState();
}

class _UpdateInfoBottomSheetState extends State<UpdateInfoBottomSheet> {
  final GlobalKey<FormState> _formFieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    String updatedUsername = '', updatedPassword = '';

    void _getAllUsers() async {
      final data = await SQLHelper.getItems();
      setState(() {
        UserModel.allUsers = data;
      });
    }

    Future<void> _updateUser(int id) async {
      await SQLHelper.updateItem(
          id, UserModel.name.toString(), UserModel.age.toString());
      _getAllUsers();
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formFieldKey,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "name",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      updatedUsername = value;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    initialValue: UserModel.allUsers[widget.index]
                        ["name"],
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    cursorHeight: 20,
                    autofocus: true,
                    textAlign: TextAlign.left,
                    validator:(val){
                      if (val ==null ||val==""){
                        return "this field is required";
                      }
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "age",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      updatedPassword = value;
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    initialValue: UserModel.allUsers[widget.index]
                        ["age"],
                    style: TextStyle(color:Colors.black,  fontSize: 18),
                    cursorHeight: 20,
                    autofocus: true,
                    textAlign: TextAlign.left,
                      validator:(val){
                        if (val ==null ||val==""){
                          return "this field is required";
                        }
                      },
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      SizedBox(width: 45),
                      InkWell(
                        onTap: () async {
                          if (_formFieldKey.currentState!.validate()) {
                            setState(() {
                              if (updatedUsername != "") {
                                UserModel.name = updatedUsername;
                              }
                              if (updatedPassword != "") {
                                UserModel.age = updatedPassword;
                              }
                            });
                            Navigator.pop(context);

                            _updateUser(
                                UserModel.allUsers[widget.index]["id"]);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.cyanAccent,
                                content: Text(
                                  'User details updated',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
