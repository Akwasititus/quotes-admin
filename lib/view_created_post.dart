import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class QuotesListPage extends StatefulWidget {
  const QuotesListPage({super.key});

  @override
  _QuotesListPageState createState() => _QuotesListPageState();
}

class _QuotesListPageState extends State<QuotesListPage> {
  late Future<List<dynamic>> _quotesFuture;
  final TextEditingController _editController = TextEditingController();

  String imagePath = 'asset/img3.jpg';

  @override
  void initState() {
    super.initState();
    _quotesFuture = fetchQuotes();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchQuotes() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('quotes')
          .orderBy('createdAt', descending: true)
          .get();
      return querySnapshot.docs;
    } catch (e) {
      EasyLoading.showError("Failed to fetch quotes: $e");
      return [];
    }
  }

  Future<bool> deleteQuote(String id) async {
    try {
      await FirebaseFirestore.instance.collection('quotes').doc(id).delete();
      EasyLoading.showSuccess("Quote deleted successfully");
      return true;
    } catch (e) {
      EasyLoading.showError("Failed to delete quote: $e");
      return false;
    }
  }

  Future<bool> updateQuote(String id, String newText) async {
    try {
      await FirebaseFirestore.instance.collection('quotes').doc(id).update({'quote': newText});
      EasyLoading.showSuccess("Quote updated successfully");
      return true;
    } catch (e) {
      EasyLoading.showError("Failed to update quote: $e");
      return false;
    }
  }

  void _onDelete(String id) async {
    final bool success = await deleteQuote(id);
    if (success) {
      setState(() {
        _quotesFuture = fetchQuotes(); // Refresh the quotes list
      });
    } else {
      EasyLoading.showError("Failed to delete quote");
    }
  }

  void _onEdit(String id, String oldText) async {
    _editController.text = oldText;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Quote'),
          content: TextField(
            controller: _editController,
            maxLines: null,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                _editController.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () async {
                final bool success = await updateQuote(id, _editController.text);
                if (success) {
                  setState(() {
                    _quotesFuture = fetchQuotes();
                  });
                }
                _editController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
              future: fetchQuotes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('No quotes found'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final quote = snapshot.data![index].data();
                      return Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 5,
                        child: ListTile(
                          title: Text(quote['quote'] ?? 'No text'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              const Divider(),
                              Text('Author: ${quote['author'] ?? 'Unknown'}'),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () => _onEdit(snapshot.data![index].id, quote['quote']),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _onDelete(snapshot.data![index].id),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}