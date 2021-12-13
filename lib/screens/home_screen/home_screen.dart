import 'package:flutter/material.dart';
import 'package:lala_awinty/admin_app/main_admin_app.dart';
import 'package:lala_awinty/constants/colors.dart';
import 'package:lala_awinty/constants/controllers.dart';
import 'package:lala_awinty/models/user.dart';
import 'package:lala_awinty/screens/recommandations_screen/recommendations_screen.dart';
import 'package:lala_awinty/widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    RecommendationsScreen(),
    Text(
      'favs',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool?>(
      future: authController.checkIfUserIsAdmin(),
      builder: (context, AsyncSnapshot<bool?> snapshot) {
        if (snapshot.hasError) {
          print('data fnd ${snapshot.data.toString()}');
          return  Scaffold(
            body: Center(
              child: Text("Something went wrong ${snapshot.error.toString()}"),
            ),
          );
        }
        if (snapshot.hasData && !snapshot.data!  == null) {
          return const Scaffold(
            body: Center(
              child: Text("User doesn't exist"),
            ),
          );
        }
        if(snapshot.hasData && snapshot.data==true){
          return const AdminApp();
        }
        else if(snapshot.hasData && snapshot.data==false){
          return Scaffold(
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.circle_outlined),
                  label: 'Recommandations',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profil',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor:primaryColor,
              onTap: _onItemTapped,
            ),
          );
        }
        return Scaffold(
          body: Center(child: LoadingWidget()),
        );
      }
    );
  }
}

