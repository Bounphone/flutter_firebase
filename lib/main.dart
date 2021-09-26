import 'package:flutter/material.dart';
import 'package:flutter_learn_firebase/screens/display.dart';
import 'package:flutter_learn_firebase/screens/formscreen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      body: TabBarView(
        children: [
          FormScreen(),
          DisplayScreen()
        ],
      ),
      backgroundColor: Colors.blue,
      bottomNavigationBar: TabBar(
        tabs: [
          Tab(text: 'Save score',),
          Tab(text: 'Students list',),
        ],
      ),
    ));
  }
}

