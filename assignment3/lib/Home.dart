import 'package:assignment1/DetailsPage.dart';
import 'package:assignment1/reusables.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController kNameController = TextEditingController();
  TextEditingController kEmailController = TextEditingController();
  TextEditingController kPRNController = TextEditingController();
  List<String> department = [
    'CSE',
    'IT',
    'Electrical',
    'Electronics',
    'Mechanical',
    'Civil'
  ];
  String? valChossen;
  List student = [];
  void clear() {
    kNameController.clear();
    kEmailController.clear();
    kPRNController.clear();
  }

  String dropdownValue = 'IT';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text(
          'Assignment 3',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FittedBox(
                child: Text(
                  "Student Information",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              kTextFormField(
                  lable: 'Name',
                  kController: kNameController,
                  obscure: false,
                  icon: const Icon(Icons.person),
                  validator: (val) {
                    if (val == '' || val == null) {
                      if (kDebugMode) {
                        print('tHIS FIeLD IS REQUIRED');
                      }
                    }
                    return null;
                  }),
              const SizedBox(
                height: 40,
              ),
              kTextFormField(
                  lable: 'Email',
                  kController: kEmailController,
                  obscure: false,
                  icon: const Icon(Icons.email),
                  validator: (val) {
                    if (val == '' || val == null) {
                      if (kDebugMode) {
                        print('tHIS FILED IS REQUIRED');
                      }
                    }
                    return null;
                  }),
              const SizedBox(
                height: 40,
              ),
              kTextFormField(
                  lable: 'PRN',
                  kController: kPRNController,
                  obscure: false,
                  icon: const Icon(Icons.person),
                  validator: (val) {
                    if (val == '' || val == null) {
                      if (kDebugMode) {
                        print('tHIS FILD IS REQUIRED');
                      }
                    }
                    return null;
                  }),
              const SizedBox(
                height: 20,
              ),
              DropdownButton<String>(
                value: dropdownValue,
                items: department.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue ?? '';
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                   setState(() {
                     Navigator.push(
                         (context),
                         MaterialPageRoute(
                             builder: (context) => Details(
                                 email: kEmailController.text,
                                 branch: dropdownValue,
                                 name: kNameController.text,
                                 prn: kPRNController.text)));
                   });


                  },
                  child: const Text('submit'))
            ],
          ),
        ),
      ),
    );
  }
}
