import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:milk_collection/api/Get.dart';
import 'package:milk_collection/auth/auth_service.dart';
import 'package:milk_collection/components/custom_loginbutton.dart';
import 'package:milk_collection/components/custom_textfield.dart';
import 'package:milk_collection/main.dart';

import 'ErrorPage.dart';

class Hello extends StatefulWidget {
  const Hello({super.key});

  @override
  State<Hello> createState() => _HelloState();
}

class _HelloState extends State<Hello> {
  bool notFound = false;
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.logout_rounded),
                  onPressed: () => {loGout(context)},
                  iconSize: 40,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 180),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  onChanged: (value) => {
                    setState(() {
                      notFound = false;
                    })
                  },
                  style: TextStyle(
                      color: notFound ? Colors.red : Colors.grey[500]),
                  controller: searchController,
                  onSubmitted: (value) => {findTournee(context, value)},
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: notFound ? Colors.red : Colors.grey.shade400),
                    ),
                    suffixIcon: (const Icon(Icons.search)),
                    suffixIconColor: notFound ? Colors.red : Colors.blueGrey,
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: notFound ? "tournée pas trouvé" : "Némuro de tournée",
                    hintStyle: TextStyle(
                        color: notFound ? Colors.red : Colors.grey[500]),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              MyButton(
                onTap: () => {
                  findTournee(context, searchController.text).then((ret) {
                    if (ret == false) {
                      searchController.text = "";
                      setState(() {
                        notFound = true;
                      });
                    }
                  }).catchError((error) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ErrorPage(error: error.message)));
                  })
                },
                text: "Submit",
                color: Colors.blueGrey,
              )
            ],
          ),
        ),
      ),
    );
  }
}