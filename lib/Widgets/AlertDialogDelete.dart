import 'package:flutter/material.dart';

import '../Services/ApiClient.dart';
import '../Views/ReservationListScreen.dart';

class AlertDialogDelete extends StatelessWidget {
   final String id; // Store the id as a class variable

   AlertDialogDelete(this.id);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirmation"),
      content: Text("Vous êtes sûr?"),
      actions: <Widget>[
        TextButton(
          child: Text("Annuler"),
          onPressed: () {
            
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Oui"),
          onPressed: () async {
            final response=await ApiClient.cancelReservation(id);
                  if (response.statusCode == 200) {
                   
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Registration est annulé avec succée"),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  } 
             // ignore: use_build_context_synchronously
             Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => ReservationListScreen()),
                      );
          },
        ),
      ],
    );
  }
}
