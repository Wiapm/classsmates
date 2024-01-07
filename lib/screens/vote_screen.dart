import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:project_flutter/screens/welcome_screen.dart';
import 'package:project_flutter/screens/chat_screen.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser; // this will give us the email

class VoteOption {
  String title;
  int count;

  VoteOption({required this.title, this.count = 0});
}

class VoteScreen extends StatefulWidget {
  @override
  _VoteScreenState createState() => _VoteScreenState();

  static const String screenRoute = 'vote_screen';
}

class _VoteScreenState extends State<VoteScreen> {
  List<TextEditingController> _optionControllers = [];
  List<VoteOption> _options = [];
  TextEditingController _suggestionController = TextEditingController();
  TextEditingController _numberOfOptionsController = TextEditingController();

  bool _showOptions = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final _auth = FirebaseAuth.instance;
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void _addOptions(int numberOfOptions) {
    setState(() {
      _optionControllers.clear();
      _options.clear();
      for (int i = 0; i < numberOfOptions; i++) {
        TextEditingController controller = TextEditingController();
        _optionControllers.add(controller);
        _options.add(VoteOption(title: 'Option ${i + 1}'));
      }
      _showOptions = true;
    });
  }

  void _voteForOption(int index) async {
    setState(() {
      _options[index].count++;
    });

    VoteOption selectedOption = _options[index];

    // Get the user's email (replace with your logic to get the email)
    User userEmail = signedInUser;

    // Create a document in the "votes" collection with a unique identifier
    DocumentReference voteRef =
        await FirebaseFirestore.instance.collection('votes').add({
      'email': userEmail.email,
      'option': selectedOption.title,
      'count': selectedOption.count,
    });

    // Print the ID of the created document to the console
    print('Document ID: ${voteRef.id}');

    // Also add the unselected options with a count of zero
    for (int i = 0; i < _options.length; i++) {
      if (i != index) {
        VoteOption unselectedOption = _options[i];
        await FirebaseFirestore.instance.collection('votes').add({
          'email': userEmail.email,
          'option': unselectedOption.title,
          'count': unselectedOption.count,
        });
      }
    }
  }

  void _showVoteResults() async {
    // Get the documents from the "votes" collection
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('votes').get();

    Map<String, int> optionCounts = {};

    // Iterate through the documents and count the options
    snapshot.docs.forEach((doc) {
      String optionTitle = doc['option'];
      int count = doc['count'];

      if (optionCounts.containsKey(optionTitle)) {
        // Option already exists, update the count if it's higher
        if (count > optionCounts[optionTitle]!) {
          optionCounts[optionTitle] = count;
        }
      } else {
        // Option doesn't exist, add it to the map
        optionCounts[optionTitle] = count;
      }
    });

    List<VoteOption> voteOptions = [];

    // Create VoteOption objects from the map
    optionCounts.forEach((title, count) {
      voteOptions.add(VoteOption(title: title, count: count));
    });

    setState(() {
      _options = voteOptions;
    });
  }

  void _deleteData() async {
    // Delete all documents in the "votes" collection
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('votes').get();
    snapshot.docs.forEach((doc) {
      doc.reference.delete();
    });

    setState(() {
      _showOptions = false;
      _options.clear();
      _optionControllers.clear();
    });
  }

  @override
  void dispose() {
    _suggestionController.dispose();
    _numberOfOptionsController.dispose();
    _optionControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 252, 195),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 211, 56, 67),
        title: Row(children: [
          Image.asset(
            'images/ff.png',
            height: 34,
          ),
          const SizedBox(
            width: 20,
          ),
          const Text(
            ' Votez ',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          )
        ]),
        actions: [
          IconButton(
              onPressed: () {
                //messagesStreams();
                Navigator.pushNamed(context, WelcomeScreen.screenRoute);
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Votre Proposition',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _suggestionController,
                  decoration: InputDecoration(
                    hintText: 'Entrer votre proposition ',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Nombre de suggestion',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _numberOfOptionsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Entrer le Nombre de suggestion',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        int numberOfOptions =
                            int.tryParse(_numberOfOptionsController.text) ?? 0;
                        _addOptions(numberOfOptions);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 211, 56, 67),
                      ),
                      child: Text(
                        'Validez',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              if (_showOptions)
                Column(
                  children: List.generate(_optionControllers.length, (index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      child: TextField(
                        controller: _optionControllers[index],
                        decoration: InputDecoration(
                          hintText: 'Entrer Le Choix ${index + 1}',
                        ),
                      ),
                    );
                  }),
                ),
              SizedBox(height: 20),
              if (_showOptions)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _options.clear();
                      for (int i = 0; i < _optionControllers.length; i++) {
                        String optionTitle = _optionControllers[i].text;
                        _options.add(VoteOption(title: optionTitle));
                      }
                      _showOptions = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 211, 56, 67),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              SizedBox(height: 20),
              if (!_showOptions)
                Column(
                  children: List.generate(_options.length, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Proposition ${index + 1}: ${_options[index].title}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Nombre: ${_options[index].count}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () => _voteForOption(index),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 32, 19, 20),
                            ),
                            child: Text(
                              'Vote',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              SizedBox(height: 20),
              if (!_showOptions)
                ElevatedButton(
                  onPressed: _showVoteResults,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 211, 56, 67),
                  ),
                  child: Text(
                    'Affichage du Résultat',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _deleteData,
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 26, 141, 236),
                ),
                child: Text(
                  'Supprimer les données',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
