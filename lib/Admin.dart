
import 'package:adminquote/post_request.dart';
import 'package:adminquote/view_created_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final TextEditingController _quoteController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _quoteController.dispose();
    super.dispose();
  }

  clearAll() {
    _quoteController.clear();
    _authorController.clear();
  }

  String getGreeting() {
    final currentHour = DateTime.now().hour;

    if (currentHour >= 5 && currentHour < 12) {
      return 'Good Morning';
    } else if (currentHour >= 12 && currentHour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: UpgradeAlert(
            child: Stack(children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('asset/img3.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 10.0, right: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
            
                          Text(
                            "${getGreeting()}, Pastor",
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "what do you have for us today?",
                            style:
                                TextStyle(fontSize: 15, fontWeight: FontWeight.w100),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                        ),
                        child:
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                maxLines: 10,
                                controller: _quoteController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Quote here...',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a quote';
                                  }
                                  // Split the input by whitespace to get the words
                                  List<String> words = value.trim().split(RegExp(r'\s+'));
                                  if (words.length > 100) {
                                    return 'The quote should not exceed 100 words.';
                                  }
                                  return null;
                                },
                              ),
                              const Divider(),
                              const SizedBox(height: 16),
                              Container(
                                  color: Colors.white.withOpacity(0.3),
                                  child: TextFormField(
                                    controller: _authorController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Who's the Author",
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the author\'s name';
                                      }
                                      return null;
                                    },
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {

                            // Creating user registration mapData
                            final Map<String, dynamic> quoteData = {
                              "quote": _quoteController.text,
                              "author": _authorController.text,
                              'createdAt': FieldValue.serverTimestamp(),
                            };
                            _quoteController.clear();
                            _authorController.clear();
                            await PostQuote.createPost(quoteData);
                          }
                        },
                        child: const Text('Create Post'),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          bottomNavigationBar: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QuotesListPage()),
              );
            },
            child: const Text("View Created Post"),
          )),
    );
  }
}
