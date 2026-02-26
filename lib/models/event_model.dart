import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String date;
  final String fullDate;
  final String time;
  final String location;
  final String imageUrl;
  final String organizer;
  final int interestedCount;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.fullDate,
    required this.time,
    required this.location,
    required this.imageUrl,
    required this.organizer,
    this.interestedCount = 0,
  });

  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return EventModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? 'TECH',
      date: data['date'] ?? '',
      fullDate: data['fullDate'] ?? '',
      time: data['time'] ?? '',
      location: data['location'] ?? '',
      imageUrl: data['imageUrl'] ?? 'https://picsum.photos/400/300',
      organizer: data['organizer'] ?? 'University Club',
      interestedCount: data['interestedCount'] ?? 0,
    );
  }
}