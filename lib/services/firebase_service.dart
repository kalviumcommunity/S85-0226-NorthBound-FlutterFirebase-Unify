import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/event_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User?> get userStream => _auth.authStateChanges();

  Stream<List<EventModel>> getEvents() {
    return _db.collection('events').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => EventModel.fromFirestore(doc)).toList());
  }

  Stream<EventModel> getEventById(String eventId) {
    return _db.collection('events').doc(eventId).snapshots().map((doc) => EventModel.fromFirestore(doc));
  }

  Future<void> updateInterest(String eventId) async {
    await _db.collection('events').doc(eventId).update({
      'interestedCount': FieldValue.increment(1),
    });
  }

  // Saved Events logic
  Future<void> toggleSaveEvent(String eventId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docRef = _db.collection('users').doc(user.uid).collection('savedEvents').doc(eventId);
    final doc = await docRef.get();

    if (doc.exists) {
      await docRef.delete();
    } else {
      await docRef.set({
        'savedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Stream<bool> isEventSaved(String eventId) {
    final user = _auth.currentUser;
    if (user == null) return Stream.value(false);

    return _db
        .collection('users')
        .doc(user.uid)
        .collection('savedEvents')
        .doc(eventId)
        .snapshots()
        .map((doc) => doc.exists);
  }

  Stream<List<EventModel>> getSavedEvents() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value([]);

    return _db
        .collection('users')
        .doc(user.uid)
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

  // Auth Functions
  Future<void> login(String email, String password) async =>
      await _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<void> signUp(String email, String password) async =>
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

  Future<void> logout() async => await _auth.signOut();
}
