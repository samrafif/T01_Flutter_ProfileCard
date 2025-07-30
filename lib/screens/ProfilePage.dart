import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage();

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> numbersList = NumberGenerator().numbers;
  Map<String, dynamic> userProfile = {
    "id": 1,
    "name": "Leanne Graham",
    "username": "Bret",
    "email": "Sincere@april.biz",
    "address": {
      "street": "Kulas Light",
      "suite": "Apt. 556",
      "city": "Gwenborough",
      "zipcode": "92998-3874",
      "geo": {
        "lat": "-37.3159",
        "lng": "81.1496"
      }
    },
    "phone": "1-770-736-8031 x56442",
    "website": "hildegard.org",
    "company": {
      "name": "Romaguera-Crona",
      "catchPhrase": "Multi-layered client-server neural-net",
      "bs": "harness real-time e-markets"
    }
  };
  
  int _counter = 0;
  String gender = 'male';
  String name = 'John Doe';
  String bio = 'This is a sample bio for the user profile. It can be updated with more information about the user.';

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      gender = _counter % 3 == 0 ? 'male' : 'female';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Card', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Container(
          child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image from URL
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(76)),
                          child: Image.network('https://thispersondoesnotexist.com/?dummy=$_counter', key: ValueKey(_counter), // ensures image widget is recreated
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return CircularProgressIndicator();
                          },),
                        ),
                      ),
                    ),
                  ),
            
                  // Content
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 24.0, 32.0, 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(name,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                )
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.verified, color: Colors.blue, size: 20),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          bio,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        
                      ],
                    ),
                  ),
            
                  // Button Row
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0,0,24.0,24.0),
                    child: OverflowBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextIcon(text: "${numbersList[0]}K", icon: Icons.people_alt),
                        TextIcon(text: numbersList[1].toString(), icon: Icons.article),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.add, color: Colors.black),
                          label: Text("Follow", style: TextStyle(color: Colors.black)),
            
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Text("*Pull to refresh the profile card, also lovingly crafted with human hands, 2% AI generated, and 98% recycled materials.", style: TextStyle(color: Colors.grey[600])),
          SizedBox(height: 20),
        ],
      ),

          // child: ListView.builder(
          //   itemCount: numbersList.length,
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       title: Text(numbersList[index]),
          //     );
          //   },),
        ),
      ),
    );
  }

  String pickRandomName(List<String> names) {
    return names[Random().nextInt(names.length)];
  }
  
  Future<void> fetchUser() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'), headers: {
      'User-Agent': 'MyFlutterApp/1.0 (CustomAgent)',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        userProfile = data;
      });
    } else {
      print('statusCode: ${response.statusCode}');
      print('response: ${response.body}');
      throw Exception('Failed to load user');
    }
  }

  Future<void> _pullRefresh() async {
    List<String> freshNumbers = await NumberGenerator().slowNumbers();
    setState(() {
      _counter++;
      numbersList = freshNumbers;
      name = pickRandomName(['Alice Gardener', 'Bob Builder', 'Charlie Chaplin', 'Diana Prince', 'Ethan Hunt', 'Fiona Apple', 'George Lucas', 'Hannah Montana']);
      bio = pickRandomName([
        'A passionate Flutter developer. That loves to create beautiful UIs. And enjoys solving complex problems.',
        'An avid traveler and photographer. Capturing moments from around the world. And sharing them with friends.',
        'A tech enthusiast. Who loves to explore new technologies. And build innovative solutions.',
        'A foodie at heart. Enjoys trying out new recipes. And sharing culinary adventures with others.',
        'A lifelong learner. Always seeking knowledge. And striving to improve every day.',
      ]);
    });
    // why use freshNumbers var? https://stackoverflow.com/a/52992836/2301224
  }
}

class TextIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  const TextIcon({ 
    Key? key,
    required this.text,
    required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.black, size: 20),
            SizedBox(width: 8),
            Text(text, style: TextStyle(fontSize: 16)),
          ],
        ),
      );
    }
  }

class NumberGenerator {
  Future<List<String>> slowNumbers() async {
    return Future.delayed(const Duration(milliseconds: 100), () => numbers,);
  }

  List<String> get numbers => List.generate(5, (index) => number);


  String get number => Random().nextInt(999).toString();
}
