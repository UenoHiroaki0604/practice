import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../firebase_options.dart'; // Firebaseの設定ファイル

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'カレンダーアプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalendarPage(),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _signInWithGoogle(); // アプリ起動時にGoogleサインインを実行
  }

  Future<void> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() {
        _currentUser = userCredential.user;
      });
    }
  }

  Future<void> _addEvent(String title, String details) async {
    if (_currentUser != null) {
      await FirebaseFirestore.instance.collection('events').add({
        'userId': _currentUser!.uid,
        'date': _selectedDay,
        'title': title,
        'details': details,
      });
    }
  }

  Widget _buildEventList() {
    if (_currentUser == null) return const Text("ユーザーが認証されていません");

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('events')
          .where('userId', isEqualTo: _currentUser!.uid)
          .where('date', isEqualTo: _selectedDay)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text("予定がありません");
        }

        var events = snapshot.data!.docs;
        if (events.isEmpty) {
          return const Text("予定がありません");
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: events.length,
          itemBuilder: (context, index) {
            var event = events[index];
            return ListTile(
              title: Text(event['title']),
              subtitle: Text(event['details']),
            );
          },
        );
      },
    );
  }

  void _showAddEventDialog() {
    String title = '';
    String details = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("予定を追加"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'タイトル'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: '詳細'),
                onChanged: (value) {
                  details = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addEvent(title, details);
                Navigator.pop(context);
              },
              child: const Text("追加"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('カレンダーアプリ'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _showAddEventDialog,
            child: const Text("予定を追加"),
          ),
          const SizedBox(height: 16),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }
}
