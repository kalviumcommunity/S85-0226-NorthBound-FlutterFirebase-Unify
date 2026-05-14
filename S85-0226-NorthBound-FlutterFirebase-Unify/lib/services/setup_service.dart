import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SetupService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> uploadEvents() async {
    try {
      // 1. Clear all existing events to ensure a clean slate.
      final snapshot = await _db.collection('events').get();
      final batch = _db.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      print("✅ Existing events cleared successfully!");

      // 2. Load the source JSON data.
      final String response = await rootBundle.loadString('assets/sample_events.json');
      final List<dynamic> data = json.decode(response);

      WriteBatch newBatch = _db.batch();

      // 3. Programmatically clean every event's time field before uploading.
      for (var eventData in data) {
        if (eventData['time'] is String) {
          eventData['time'] = eventData['time']
              .replaceAll('\u202F', ' ') // Narrow No-Break Space
              .replaceAll('\u00A0', ' ') // Standard No-Break Space
              .trim();
        }

        DocumentReference docRef = _db.collection('events').doc();
        newBatch.set(docRef, eventData);
      }
      
      // 4. Commit the clean data to Firebase.
      await newBatch.commit();
      print("✅ New, clean events uploaded successfully!");

    } catch (e) {
      print("❌ Error setting up events: $e");
    }
  }
}
