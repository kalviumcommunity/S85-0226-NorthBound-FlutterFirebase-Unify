import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SetupService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> uploadEvents() async {
    try {
      final String response = await rootBundle.loadString('sample_events.json');
      final data = await json.decode(response) as List;

      WriteBatch batch = _db.batch();

      for (var eventData in data) {
        // Use a consistent, unique ID to prevent duplicates if run multiple times
        String docId = eventData['title'].toString().replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_').toLowerCase();
        DocumentReference docRef = _db.collection('events').doc(docId);
        batch.set(docRef, eventData, SetOptions(merge: true));
      }
      
      await batch.commit();
      print("✅ Events uploaded/updated successfully!");

    } catch (e) {
      // Catch and print errors instead of crashing the app
      print("❌ Error uploading events: $e");
      print("‼️ IMPORTANT: Have you updated your Firestore security rules as instructed?");
    }
  }
}
