import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Categorie.dart';
import '../Models/Product.dart';
import '../Services/ApiClient.dart';
import '../Utils/size_config.dart';
import '../Views/HomeScreen.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  EditProductScreen({required this.product});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  int? _selectedCategoryId;
  String _selectedCategoryName = '';
  List<Categorie> _categories = [];
  List<File> _selectedImages = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _initFormData();
  }


 void _initFormData() {
    _nameController.text = widget.product.nomProduit;
    _descriptionController.text = widget.product.description;
    _selectedCategoryId = widget.product.categorieId;

    // Initialize _selectedImages with product images
    _selectedImages.addAll(widget.product.images.map((imagePath) => File(imagePath)));

    // Set initial selected category name
    _selectedCategoryName = _categories
        .firstWhere((categorie) => categorie.id == _selectedCategoryId, orElse: () => Categorie(id: 0, categorieName: '', image: ''))
        .categorieName;
  }




  Future<void> _fetchCategories() async {
    try {
      List<Categorie> categories = await ApiClient.getCategories();
      setState(() {
        _categories = categories;
      });

      // Set the initial selected category name based on the product's category
      if (_selectedCategoryId != null) {
        _selectedCategoryName = _categories
            .firstWhere((categorie) => categorie.id == _selectedCategoryId, orElse: () => Categorie(id: 0, categorieName: '', image: ''))
            .categorieName;
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

 Future<void> _selectImages() async {
  final pickedFiles = await ImagePicker().pickMultiImage();

  if (pickedFiles != null) {
    setState(() {
      // Add the newly picked images to the existing list
      _selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
    });
  }
}



  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Edit Product",
          style: TextStyle(
            fontFamily: 'Varela',
            fontSize: 20.0,
            color: Color(0xFF545D68),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/edit.png',
                      height: getProportionateScreenHeight(100),
                    ),
                    Divider(),
                    SizedBox(height: 16),
                    _selectedImages.isNotEmpty
    ? SizedBox(
        height: 200.0,
        child: ListView.builder(
  scrollDirection: Axis.horizontal,
  itemCount: _selectedImages.length,
  itemBuilder: (context, index) {
    return Stack(
      children: [
        Padding(
  padding: EdgeInsets.only(right: 8.0),
  child: _selectedImages[index].path.startsWith('http')
      ? Image.network(
          _selectedImages[index].path,
          height: 200,
          width: 200,
        )
      : Image.file(
          _selectedImages[index],
          height: 200,
          width: 200,
        ),
),
        Positioned(
          top: 8.0,
          right: 8.0,
          child: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _removeImage(index);
            },
          ),
        ),
      ],
    );
  },
),
      )
    : Placeholder(
        fallbackHeight: 200.0,
      ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _selectImages,
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(color: Colors.black),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_a_photo),
                          SizedBox(width: 15.0),
                          Text('Select Images'),
                        ],
                      ),
                    ),
                    Divider(),
                    _buildTextField(
                      controller: _nameController,
                      label: 'Product Name',
                    ),
                    _buildTextField(
                      controller: _descriptionController,
                      label: 'Description',
                    ),
                    _buildDropdown(),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _editProduct();
                        }
                      },
                      child: Text('Edit Product'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Please enter a $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown() {
  print('_categories length: ${_categories.length}');
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    child: DropdownButtonFormField<int>(
      value: _selectedCategoryId,
      items: _categories.map((categorie) {
        return DropdownMenuItem<int>(
          value: categorie.id,
          child: Text(categorie.categorieName),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategoryId = value;
        });
      },
      decoration: InputDecoration(labelText: 'Category'),
      validator: (value) {
        if (value == null) {
          return 'Please select a category';
        }
        return null;
      },
    ),
  );
}


  Future<void> _editProduct() async {
  String nomProduit = _nameController.text;
  String description = _descriptionController.text;

  try {
    final response = await ApiClient.updateProduct(
      productId: widget.product.id,
      nomProduit: nomProduit,
      description: description,
      categorieId: _selectedCategoryId ?? 0,
    );

    if (true) {
  // Product edited successfully
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Product edited successfully'),
      duration: Duration(seconds: 3),
    ),
  );

  // Upload new images
  await _uploadImages(widget.product.id);

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );
} else {
  // Handle the error
  print('Failed to edit product. Status code:');
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Failed to edit product. Please try again.'),
      duration: Duration(seconds: 3),
    ),
  );
}

  } catch (e) {
    print('Error editing product: $e');
  }
}


  Future<void> _uploadImages(int productId) async {
    try {
      if (_selectedImages.isNotEmpty) {
        for (File image in _selectedImages) {
          Map<String, dynamic> response =
              await ApiClient.uploadImage(productId, image);

          // Check the response from the API
          if (response.containsKey('error')) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Image upload failed: ${response['error']}'),
                duration: Duration(seconds: 2),
              ),
            );
            return; // Stop if any image upload fails
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Images added to your product successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Select at least one image'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading images: $error'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
