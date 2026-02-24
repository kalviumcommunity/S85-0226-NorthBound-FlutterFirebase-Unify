import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/event_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User?> get userStream => _auth.authStateChanges();
  String? get userId => _auth.currentUser?.uid;

  Stream<List<EventModel>> getEvents() {
    return _db.collection('events').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => EventModel.fromFirestore(doc)).toList());
  }

  Stream<EventModel> getEventById(String eventId) {
    return _db.collection('events').doc(eventId).snapshots().map((doc) => EventModel.fromFirestore(doc));
  }

  // Updated Check-In / Check-Out Logic
  Future<void> toggleCheckIn(String eventId, bool isCheckingIn) async {
    final uid = userId;
    if (uid == null) return;

    final batch = _db.batch();
    final eventRef = _db.collection('events').doc(eventId);
    final checkInRef = _db.collection('users').doc(uid).collection('checkIns').doc(eventId);

    if (isCheckingIn) {
      batch.set(checkInRef, {'timestamp': FieldValue.serverTimestamp()});
      batch.update(eventRef, {'interestedCount': FieldValue.increment(1)});
    } else {
      batch.delete(checkInRef);
      batch.update(eventRef, {'interestedCount': FieldValue.increment(-1)});
    }

    await batch.commit();
  }

  Stream<bool> isUserCheckedIn(String eventId) {
    final uid = userId;
    if (uid == null) return Stream.value(false);
    return _db
        .collection('users')
        .doc(uid)
        .collection('checkIns')
        .doc(eventId)
        .snapshots()
        .map((doc) => doc.exists);
  }

  // Saved Events logic
  Future<void> toggleSaveEvent(String eventId) async {
    final uid = userId;
    if (uid == null) return;

    final docRef = _db.collection('users').doc(uid).collection('savedEvents').doc(eventId);
    final doc = await docRef.get();

    if (doc.exists) {
      await docRef.delete();
    } else {
      await docRef.set({'savedAt': FieldValue.serverTimestamp()});
    }
  }

  Stream<bool> isEventSaved(String eventId) {
    final uid = userId;
    if (uid == null) return Stream.value(false);
    return _db
        .collection('users')
        .doc(uid)
        .collection('savedEvents')
        .doc(eventId)
        .snapshots()
        .map((doc) => doc.exists);
  }

  Stream<List<EventModel>> getSavedEvents() {
    final uid = userId;
    if (uid == null) return Stream.value([]);

    return _db
        .collection('users')
        .doc(uid)
        .collection('savedEvents')
        .snapshots()
        .asyncMap((snapshot) async {
      List<EventModel> events = [];
      for (var doc in snapshot.docs) {
        final eventDoc = await _db.collection('events').doc(doc.id).get();
        if (eventDoc.exists) {
          events.add(EventModel.fromFirestore(eventDoc));
        }
      }
      return events;
    });
  }

  Future<void> login(String email, String password) async =>
      await _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<void> signUp(String email, String password) async =>
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

  Future<void> logout() async => await _auth.signOut();
}
