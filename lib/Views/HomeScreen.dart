import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_simple_page/Views/login.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../Services/ApiClient.dart';
import '../Utils/Consts.dart';
import '../Widgets/MenuBar.dart';

class Post {
  final String username;
  final String userImage;
  final int id;
  final String body;
  final List<String> images;
  final int likesCount;
  final bool selfLiked;
  final int commentsCount;

  Post({
    required this.username,
    required this.userImage,
    required this.id,
    required this.body,
    required this.images,
    required this.likesCount,
    required this.selfLiked,
    required this.commentsCount,
  });
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> _postList = [];
  int _selectedIndex = 0;

  // Define a GlobalKey for the Scaffold to open the drawer from the app bar
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // Add static post data
    _postList = [
      Post(
        username: 'Mejri Mohamed ali',
        userImage: 'https://scontent.ftun1-2.fna.fbcdn.net/v/t39.30808-6/376685528_2299756693553222_1992828648671393085_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=5f2048&_nc_ohc=u4WvCz5UB1UAX_qzuNF&_nc_ht=scontent.ftun1-2.fna&cb_e2o_trans=q&oh=00_AfDsvNuftcA_6uA3xT5uT8lqtbOVqRezMQ4Sf_djRCOT8Q&oe=653DC6A1',
        id: 1,
        body: 'Audi 80',
        images: [
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Audi80-1992.JPG/1200px-Audi80-1992.JPG',
          'https://upload.wikimedia.org/wikipedia/commons/2/2c/1989_Audi_80_S_1.8.jpg',
          'https://upload.wikimedia.org/wikipedia/commons/d/d0/Audi_80_B4_Red.jpg',
          'https://voyage.aprr.fr/sites/default/files/styles/banner_image/public/2022-03/Audi%2080.jpeg?itok=LUyWuACK',
        ],
        likesCount: 10,
        selfLiked: false,
        commentsCount: 5,
      ),
      // Add more static posts as needed
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 152, 185, 252),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
      ),
      drawer: buildMenuBar(selectedIndex: _selectedIndex),
      body: ListView.builder(
        itemCount: _postList.length,
        itemBuilder: (BuildContext context, int index) {
          Post post = _postList[index];
          return Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(post.userImage),
                  ),
                  title: Text(post.username),
                ),
                SizedBox(height: 8),
                Text(post.body),
                if (post.images.isNotEmpty)
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                    ),
                    items: post.images
                        .map((image) => GestureDetector(
                              onTap: () {
                                // Handle image tap to view in detail
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                Divider(),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            Consts.onItemTapped(context, _selectedIndex);
          });
        },
        items: Consts.navBarItems,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
