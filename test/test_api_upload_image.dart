import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_simple_page/Services/ApiClient.dart'; 

void main() {
  group('ApiClient uploadImage', () {
    test('should upload an image successfully', () async {
      // Arrange
      final int productId = 1; 
      final File imageFile = File('test/assests/test_image.jpg'); 

      
      final Map<String, dynamic> response = await ApiClient.uploadImage(productId, imageFile);

      // Assert
      expect(response.containsKey('success'), true);
      
    });

   
  });
}
