import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_simple_page/Views/AddProductScreen.dart';
import 'package:flutter_simple_page/main.dart';
import 'dart:io';
import 'package:flutter_simple_page/Models/Categorie.dart';
import 'package:mockito/mockito.dart';


void main() {
  testWidgets('Test scenario  valid for adding product', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();
     List<Categorie> exampleCategories = [
      Categorie(
        id: 1,
        categorieName: "Clothes",
        image: "https://example.com/electronics.jpg",
      ),
      Categorie(
        id: 2,
        categorieName: "Smartphone",
        image: "https://example.com/clothing.jpg",
      ),
  
    ];
    final File imageFile = File('test/assests/test_image.jpg');
    // Navigate to AddProductScreen
    Navigator.push(
      tester.element(find.byType(MyApp)),
      MaterialPageRoute(builder: (context) =>  AddProductScreen(categoriessends: exampleCategories,imageselected:imageFile)),
    );

    
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Samsung A20');
    await tester.enterText(find.byType(TextFormField).at(1), 'Samsung Description');
   
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -300));
    await tester.pumpAndSettle();

    print(tester.binding.renderViewElement?.toDiagnosticsNode());

    await tester.tap(find.byKey(Key('categoryDropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Smartphone'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ElevatedButton).at(1));
    await tester.pumpAndSettle();
    expect(find.text('Moving to api'), findsOneWidget);
   

  });
  
}



