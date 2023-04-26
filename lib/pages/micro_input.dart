import 'package:flutter/material.dart';
import 'package:milk_collection/api/Get.dart';
import 'package:milk_collection/api/Post.dart';
import 'package:milk_collection/components/custom_loginbutton.dart';
import 'package:milk_collection/models/data_models.dart';
import 'package:milk_collection/pages/ErrorPage.dart';

List<String> bacToString(List<Baclait>? results) {
  List<String> ret = [];

  results?.forEach((element) {
    ret.add(element.reference ?? "");
  });
  return ret;
}

Future<bool> parseFloat(String input) async {
  try {
    double.parse(input);
    return true;
  } catch (e) {
    throw ("not float");
  }
}

int StringtoId(String? item, List<Baclait>? results) {
  for (int i = 0; i < results!.length; i++) {
    if (item == results[i].reference) {
      return results[i].id ?? 0;
    }
  }
  return 0;
}

Future<int> creating(int? bacID, String quantity, int? collectionID) async {
  try {
    int ret = await initLine(bacID, quantity, collectionID);
    return ret;
  } catch (err) {
    throw Exception("error in Server");
  }
}

class BacLaitInput extends StatefulWidget {
  int collection;
  int? uniteId;

  BacLaitInput({super.key, required this.collection, this.uniteId});

  @override
  State<BacLaitInput> createState() => _BacLaitInputState();
}

class _BacLaitInputState extends State<BacLaitInput> {
  List<Baclait>? bacs;
  bool built = false;
  String? selectedBac;
  bool inputError = false;
  final quantitycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            const SizedBox(height: 150),
            FutureBuilder(
              future: getBacAlait(widget.uniteId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bacs = snapshot.data;

                  if (built == false) {
                    selectedBac = bacToString(bacs)[0];
                    built = true;
                  }

                  return (Column(
                    children: [
                      DropdownButton<String>(
                        value: selectedBac,
                        items: bacToString(bacs)
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (item) => setState(() {
                          selectedBac = item;
                        }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextField(
                          onChanged: (value) => {
                            parseFloat(value)
                                .then((value) => {
                                      if (inputError == true)
                                        setState(() {
                                          inputError = false;
                                        })
                                    })
                                .catchError((err) {
                              setState(() {
                                inputError = true;
                              });
                            }),
                          },
                          style: TextStyle(
                              color:
                                  inputError ? Colors.red : Colors.grey[500]),
                          controller: quantitycontroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: inputError
                                      ? Colors.red
                                      : Colors.grey.shade400),
                            ),
                            suffixText: "L",
                            suffixStyle: TextStyle(
                                fontSize: 20,
                                color:
                                    inputError ? Colors.red : Colors.blueGrey),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            hintText: "Quantité",
                            hintStyle: TextStyle(
                                color:
                                    inputError ? Colors.red : Colors.grey[500]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      MyButton(
                          onTap: () {
                            parseFloat(quantitycontroller.text)
                                .catchError((err) {
                              setState(() {
                                inputError = true;
                              });
                            }).then((val) {
                              creating(
                                      StringtoId(selectedBac, bacs),
                                      quantitycontroller.text,
                                      widget.collection)
                                  .catchError((onError) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            ErrorPage(error: onError))));
                              }).then((value) => {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    BacLaitInput(
                                                        collection: widget
                                                            .collection,uniteId: widget.uniteId,))))
                                      });
                            });
                            //createcollection and page for a new one
                            ;
                            print("hello");
                          },
                          text: "continue",
                          color: Colors.blueGrey),
                      const SizedBox(
                        height: 20,
                      ),
                      MyButton(
                          onTap:() {
                            parseFloat(quantitycontroller.text)
                                .catchError((err) {
                              setState(() {
                                inputError = true;
                              });
                            }).then((val) {
                              creating(
                                      StringtoId(selectedBac, bacs),
                                      quantitycontroller.text,
                                      widget.collection)
                                  .catchError((onError) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            ErrorPage(error: onError))));
                              }).then((value) => {
                                        Navigator.pop(context)
                                      });
                            });
                            //createcollection and page for a new one
                            ;
                            
                          },
                          text: "Finish",
                          color: Color.fromARGB(255, 38, 60, 49))
                    ],
                  ));
                }
                return Text("error");
              },
            )
          ],
        ),
      )),
    );
  }
}
