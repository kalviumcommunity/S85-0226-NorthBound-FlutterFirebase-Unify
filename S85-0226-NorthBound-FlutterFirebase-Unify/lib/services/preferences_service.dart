import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _bookmarkKey = 'bookmarked_events';

  // Save an event ID to the local list
  Future<void> toggleBookmark(String eventId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList(_bookmarkKey) ?? [];

    if (bookmarks.contains(eventId)) {
      bookmarks.remove(eventId);
    } else {
      bookmarks.add(eventId);
    }

    await prefs.setStringList(_bookmarkKey, bookmarks);
  }

  // Check if an event is currently bookmarked
  Future<bool> isBookmarked(String eventId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList(_bookmarkKey) ?? [];
    return bookmarks.contains(eventId);
  }

  // Get all bookmarked IDs
  Future<List<String>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_bookmarkKey) ?? [];
  }
}