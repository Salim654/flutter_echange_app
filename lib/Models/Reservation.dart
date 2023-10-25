import 'Terrain.dart';
import 'User.dart';

class Reservation {
  String id;
  User user;
  Terrain terrain;
  String? date;
  int heure;
  int etat;

  Reservation({
    required this.id,
    required this.user,
    required this.terrain,
     this.date,
    required this.heure,
    required this.etat,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['_id'],
      user: User.fromJson(json['user']),
      terrain: Terrain.fromJson(json['terrain']),
      date: json['date'],
      heure: json['heure'],
      etat: json['etat'],
    );
  }
}



