import 'package:flutter/material.dart';
import 'package:milk_collection/api/Get.dart';
import 'package:milk_collection/api/Post.dart';
import 'package:milk_collection/components/custom_loginbutton.dart';
import 'package:milk_collection/components/custom_textfield.dart';
import 'package:milk_collection/models/data_models.dart';
import 'package:milk_collection/pages/micro_input.dart';

import 'ErrorPage.dart';

List<String> resultToString(List<Result>? results) {
  List<String> ret = [];

  results?.forEach((element) {
    ret.add(element.name ?? "");
  });
  return ret;
}

int StringtoId(String? item, List<Result>? results) {
  for (int i = 0; i < results!.length; i++) {
    if (item == results[i].name) {
      return results[i].id ?? 0;
    }
  }
  return 0;
}

Future<int> Create(
    int? tourneeID, int? sourceID, int? centreID, dynamic context) async {
  try {
    int ret = await initCollection(tourneeID, sourceID, centreID);
    return ret;
  } catch (err) {
    throw Exception("error in Server");
  }
}

class collecInput extends StatefulWidget {
  Tournee tournee;
  int index;
  collecInput({super.key, required this.tournee, required this.index});

  @override
  State<collecInput> createState() => _collecInputState();
}

class _collecInputState extends State<collecInput> {
  final usernameController = TextEditingController();
  bool built = false;
  bool isError = false;
  String? selectedDestination;
  List<Result>? destinations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
      ),
      // ignore: avoid_unnecessary_containers
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            FutureBuilder(
              future: getDestinations(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  destinations = snapshot.data;
                  if (built == false) {
                    selectedDestination = resultToString(destinations)[0];
                    built = true;
                  }
                  return Column(
                    children: [
                      (Container(
                        child: DropdownButton<String>(
                          value: selectedDestination,
                          items: resultToString(destinations)
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (item) => setState(() {
                            selectedDestination = item;
                          }),
                        ),
                      )),
                      const SizedBox(
                        height: 30,
                      ),
                      MyButton(
                          onTap: () => {
                                Create(
                                        widget.tournee.id,
                                        widget.tournee.trajetIds![widget.index]
                                            .id,
                                        StringtoId(
                                            selectedDestination, destinations),
                                        context)
                                    .then((value) => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BacLaitInput(
                                                  collection: value,
                                                  uniteId: widget
                                                      .tournee
                                                      .trajetIds![widget.index]
                                                      .id,
                                                ))))
                                    .catchError((err) => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ErrorPage(
                                                          error: err.message))),
                                        })
                              },
                          text: "Continue",
                          color: Colors.blueGrey),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return (Center(
                    child: Column(children: [
                      const SizedBox(
                        height: 0,
                      ),
                      Text(
                        snapshot.error.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.replay_outlined),
                        iconSize: 70,
                      )
                    ]),
                  ));
                } else {
                  return (const CircularProgressIndicator());
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        )),
      ),
    );
  }
}
