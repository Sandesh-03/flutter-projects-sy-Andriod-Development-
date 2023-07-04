// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:assignment5/widget/reusables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helpers/sql_helper.dart';
import '../model/user_model.dart';
import 'all_data.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final GlobalKey<FormState> _formFieldKey = GlobalKey();

  bool _isLoading = false;

  void _getAllUsers() async {
    final data = await SQLHelper.getItems();
    setState(() {
      UserModel.allUsers = data;
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

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        decoration:BoxDecoration (
        gradient: LinearGradient(
          colors: [
            Colors.redAccent.withOpacity(0.4),
            Colors.blueAccent.withOpacity(0.4),
          ]
        )
        ),
        child: ModalProgressHUD(
          inAsyncCall: _isLoading,
          progressIndicator: CircularProgressIndicator(),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 364 / 3),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white.withOpacity(0.4),
                    ),

                    child: Center(
                      child: Image(
                        image: AssetImage("assets/sqlite.png"),
                        alignment: Alignment.center,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  SizedBox(height: 223 / 3),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 105 / 3),
                    child: Form(
                      key: _formFieldKey,
                      child: Column(
                        children: [
                          // MyTextInput(
                          //   icon: Icons.person,
                          //   hintText: 'Username',
                          //   controller: _usernameController,
                          //   validator: userNameValidator,
                          //   textInputAction: TextInputAction.next,
                          // ),
                          kTextFormField(
                            lable: "name",
                            kController: nameController,
                            obscure: false,
                            icon: Icon(Icons.person),
                            validator:(val){
                              if (val ==null ||val==""){
                                return "this field is required";
                              }
                            },
                            keybordtype: TextInputType.text,
                          ),
                          SizedBox(height: 45.6 / 3),
                          // MyTextInput(
                          //   hintText: "Password",
                          //   icon: Icons.lock_rounded,
                          //   controller: _passwordController,
                          //   validator: passwordRequireValidator,
                          //   textInputAction: TextInputAction.done,
                          // ),
                          kTextFormField(
                            lable: "age",
                            kController: ageController,
                            obscure: false,
                            icon: Icon(Icons.person),
                            inputformaters: [
                              LengthLimitingTextInputFormatter(3),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (val) {
                              if (val == null || val == "") {
                                return "this field is required";
                              }
                            },
                            keybordtype: TextInputType.number,
                          ),
                          SizedBox(height: 60),
                          InkWell(
                            onTap: () async {
                              if (_formFieldKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                  UserModel.name = nameController.text;
                                  UserModel.age = ageController.text;
                                });
                                await _addUser();
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllData(),
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Successfully added a user',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: MyButton(text: "add"),
                          ),
                          SizedBox(height: 112.7 / 3),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllData(),
                                ),
                              );
                            },
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              height: 50,
                              width: size.width * 0.5,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                "see all",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 74 / 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
