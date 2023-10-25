import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/Consts.dart';
import '../Views/login.dart';

Widget buildMenuBar({required int selectedIndex}) {
  return MenuBar(selectedIndex: selectedIndex);
}

class MenuBar extends StatefulWidget {
  final int selectedIndex;

  MenuBar({required this.selectedIndex});

  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  String userName = '';
  String userEmail = '';
  String token = '';

  @override
  void initState() {
    super.initState();
    // Fetch the user's data from your data source and update the state
    fetchUserData();
  }

  // Method to fetch the user's data (replace this with your data retrieval logic)
  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? 'Default Name';
      userEmail = prefs.getString('email') ?? 'user@example.com';
      token = prefs.getString('token') ?? 'token';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 152, 185, 252),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      'https://scontent.ftun1-2.fna.fbcdn.net/v/t39.30808-6/376685528_2299756693553222_1992828648671393085_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=5f2048&_nc_ohc=u4WvCz5UB1UAX_qzuNF&_nc_ht=scontent.ftun1-2.fna&cb_e2o_trans=q&oh=00_AfDsvNuftcA_6uA3xT5uT8lqtbOVqRezMQ4Sf_djRCOT8Q&oe=653DC6A1'),
                ),
                SizedBox(height: 10),
                Text(
                  userName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  userEmail,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Accueil'),
            onTap: () {
              Consts.onItemTapped(context, 0);
            },
            selected: widget.selectedIndex == 0,
          ),
          ListTile(
            leading: Icon(Icons.date_range_outlined),
            title: Text('Echange'),
            onTap: () {
              Consts.onItemTapped(context, 1);
            },
            selected: widget.selectedIndex == 1,
          ),
          ListTile(
            leading: Icon(Icons.date_range_outlined),
            title: Text('Mes produits'),
            onTap: () {
              Consts.onItemTapped(context, 1);
            },
            selected: widget.selectedIndex == 1,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Consts.onItemTapped(context, 2);
            },
            selected: widget.selectedIndex == 2,
          ),
          ListTile(
            leading: Icon(Icons.logout_sharp),
            title: Text('Deconnection'),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PageLogin(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
