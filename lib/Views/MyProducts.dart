import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../Models/Product.dart';
import '../Services/ApiClient.dart';
import '../Utils/Consts.dart';
import '../Widgets/MenuBar.dart';
import 'AddProductScreen.dart';
import 'EditProductScreen.dart';
import 'ProductDescription.dart';
import 'OfferList.dart';
import 'package:flutter_simple_page/Models/Categorie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProducts extends StatefulWidget {
  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  List<Product> _productList = [];
  int _selectedIndex = 1;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _fetchUserProducts();
    super.initState();
  }

  Future<void> _fetchUserProducts() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var iduser = prefs.getString('id');

      if (iduser != null) {
        final products = await ApiClient.getUserProducts(iduser);
        setState(() {
          _productList = products;
        });
      } else {
        print('no id ');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Widget _buildProductItem(Product product) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ProductDescription(product: product),
        //   ),
        // );
      },
      child: Container(
        margin: EdgeInsets.all(37),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 8),
                      Text('Delete'),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(Icons.local_offer),
                      SizedBox(width: 8),
                      Text('Offres'),
                    ],
                  ),
                ),
              ],
              onSelected: (int index) {
                _handleButtonAction(index, product);
              },
            ),
            if (product.images.isNotEmpty)
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                ),
                items: product.images.map((imagePath) {
                  return Image.network(
                    imagePath,
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                  );
                }).toList(),
              ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  product.nomProduit,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleButtonAction(int index, Product product) {
  switch (index) {
    case 0:
      // Handle Edit button click
      _navigateToEditScreen(product);
      break;
    case 1:
      _showDeleteConfirmation(context, product);
      break;
    case 2:
      _navigateTooffreScreen(product.id.toString());
      // Handle Offres button click
      break;
    default:
      // Handle Edit button click
      break;
  }
}

void _navigateToEditScreen(Product product) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditProductScreen(product: product),
    ),
  );
}
void _navigateTooffreScreen(String productid) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => OfferList(idProduit: productid),
    ),
  );
}

  

  void _showDeleteConfirmation(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Are you sure you want to delete this product?',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 450,
                  child: ElevatedButton(
                    onPressed: () async {
                    try {
                      await ApiClient.deleteUserProduct(product.id);
                      _fetchUserProducts(); // Refresh the list after deletion
                      Navigator.of(context).pop();
                    } catch (e) {
                      print('Delete error: $e');
                    }
                  },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  width: 450,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); 
                      _showSnackBar('Product deleted successfully');// Close the bottom sheet
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  

  void _showSnackBar(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
                Text(
                  'Mes Produits',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: _productList.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = _productList[index];
                  return _buildProductItem(product);
                },
              ),
            ),
          ],
        ),
      ),
      drawer: buildMenuBar(selectedIndex: _selectedIndex),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddProductScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  CustomIconButton({
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(
          '',
          style: TextStyle(
            fontFamily: 'Varela',
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
