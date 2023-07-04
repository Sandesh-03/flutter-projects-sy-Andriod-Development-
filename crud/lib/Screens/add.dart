import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/reusables.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();

  addProduct() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      if (kDebugMode) {
        print("Form is vaid ");
      }

      if (kDebugMode) {
        print('Data for login ');
      }
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();




  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add New student'),
      ),
      body: Card(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 20,
                ),
                kTextFormField(
                  lable: "name",
                  kController: nameController,
                  obscure: false,
                  icon: const Icon(Icons.person),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' Name Required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                kTextFormField(
                  lable: "age",
                  kController: ageController,
                  obscure: false,
                  icon: const Icon(Icons.escalator_warning_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' age Required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),


                const SizedBox(
                  height: 30,
                ),

                const SizedBox(
                  height: 30,
                ),
                Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        Map<String,String> addToCloud = {
                          'name':nameController.text,
                          'age':ageController.text

                        };
                        FirebaseFirestore.instance.collection('students').add(addToCloud);


                        nameController.clear();
                        ageController.clear();
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Submit",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: kButtontext,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );

  }

}
