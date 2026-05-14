import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../screens/detail_screen.dart';
// This widget displays an event card with image and details,
// and navigates to DetailScreen with event data when tapped.
// A reusable UI card widget that displays event details such as image, title, date, and location.
/// A reusable card widget that displays event information.
///
/// This widget shows:
/// - Event image
/// - Category tag
/// - Title
/// - Date & time
/// - Location
///
/// On tap, it navigates to [DetailScreen] with the selected event.
class EventCard extends StatelessWidget {
  final EventModel event;
  const EventCard({required this.event, super.key});
/// This widget is designed with a flexible layout structure,
/// allowing it to adapt to different screen sizes such as mobile and tablet.
  @override
  Widget build(BuildContext context) {
    // The layout uses flexible sizing (double.infinity, Expanded)
  // to adapt across different screen sizes and prevent overflow.

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailScreen(event: event)),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF241A7F).withOpacity(0.08),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: const Color(0xFF241A7F).withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    event.imageUrl,
                    height: 190,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      event.category.toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFF241A7F),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF241A7F)),
                      const SizedBox(width: 8),
                      Text(
                        "${event.date} • ${event.time}",
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF241A7F)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          event.location,
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
