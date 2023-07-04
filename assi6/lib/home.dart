import 'package:assi6/display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController kNameCont = TextEditingController();
  TextEditingController kNumberCont = TextEditingController();
  int? val = 1;
  bool selected = false;
  bool ischecked =false;
  late String name;
  late String number;
  late String dob;
  late String gender;

  List<String> department = [
    'CSE',
    'IT',
    'Electrical',
    'Electronics',
    'Mechanical',
    'Civil'
  ];
  String? valChossen;
  void clear() {
    kNameCont.clear();
    kNumberCont.clear();
  }

  String dropdownValue = 'IT';

  DateTime date = DateTime.now();
  void ShowDate() {
    showDatePicker(
            context: (context),
            initialDate: DateTime.now(),
            firstDate: DateTime(1800),
            lastDate: DateTime(2025))
        .then((value) {
      setState(() {
        date = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Student Information'),
        leading: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(33)),
              color: Colors.white),
          child: Image.asset(
            'assets/walchand_logo-removebg-preview.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: kNameCont,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))
                          //hintTextDirection: TextDirection.rtl,
                          ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: kNumberCont,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(fontSize: 18),
                          labelText: "Mobile Number",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))
                          //hintTextDirection: TextDirection.rtl,
                          ),
                    ),
                  ),
                ),
              ),
              const FittedBox(
                  child: Text(
                "Branch",
                style: TextStyle(fontSize: 23, color: Colors.black45),
              )),
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
                height: 20,
              ),
              const FittedBox(
                  child: Text(
                "Gender",
                style: TextStyle(fontSize: 23, color: Colors.black45),
              )),
              Card(
                child: Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          gender= 'Female';
                          val = value;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Female"),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          gender= 'Male';
                          val = value;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Male"),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: [
                    Radio(
                      value: 3,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          gender= 'other';
                          val = value;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Other"),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const FittedBox(
                  child: Text(
                "Date Of Birth",
                style: TextStyle(fontSize: 23, color: Colors.black45),
              )),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      selected
                          ? Text("${date.day} / ${date.month} / ${date.year}")
                          : const Text("Date of Birth"),
                      IconButton(
                          onPressed: () {
                            selected = true;
                            ShowDate();
                          },
                          icon: const Icon(Icons.date_range))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),

              Row(
                children: [
                  Checkbox(
                      value: ischecked,
                      onChanged: (newBool) {
                        setState(() {
                          ischecked = newBool!;
                        });
                      }),
                  Row(
                    children:  const [
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text("Privacy Policy",
                            style: TextStyle(color: Colors.purple)),
                      ),
                      FittedBox(child: Text("&",)),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text("End User License Agreement",
                            style: TextStyle(color: Colors.purple)),
                      )
                    ],
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if(ischecked ==true){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Display(
                                  number: kNumberCont.text,
                                  name: kNameCont.text.trim(),
                                  branch: dropdownValue,
                                  dob: "${date.day} / ${date.month} / ${date.year}",
                                  gender: gender,
                                )));

                      }
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
