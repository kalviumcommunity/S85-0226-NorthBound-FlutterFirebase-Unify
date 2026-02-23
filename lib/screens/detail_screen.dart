import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:share_plus/share_plus.dart';
import '../models/event_model.dart';
import '../services/firebase_service.dart';

class DetailScreen extends StatefulWidget {
  final EventModel event;
  const DetailScreen({required this.event, super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EventModel>(
      stream: FirebaseService().getEventById(widget.event.id),
      builder: (context, snapshot) {
        final event = snapshot.data ?? widget.event;
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeroImage(context, event),
                    _buildContent(context, event),
                  ],
                ),
              ),
              _buildAppBar(context, event),
              _buildBottomBar(context, event),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context, EventModel event) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.white.withOpacity(0.8),
              padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 8, 16, 16),
              child: Row(
                children: [
                  _buildIconButton(
                    context,
                    Icons.arrow_back,
                    onTap: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Event Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ),
                  _buildIconButton(
                    context, 
                    Icons.share_outlined,
                    onTap: () {
                      Share.share('Check out this event: ${event.title}\nAt ${event.location} on ${event.date}');
                    },
                  ),
                  const SizedBox(width: 8),
                  StreamBuilder<bool>(
                    stream: FirebaseService().isEventSaved(event.id),
                    builder: (context, snapshot) {
                      final isSaved = snapshot.data ?? false;
                      return _buildIconButton(
                        context, 
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        iconColor: isSaved ? const Color(0xFF241A7F) : Colors.black87,
                        onTap: () => FirebaseService().toggleSaveEvent(event.id),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _buildIconButton(BuildContext context, IconData icon, {VoidCallback? onTap, Color iconColor = Colors.black87}) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
      );

  Widget _buildHeroImage(BuildContext context, EventModel event) => Padding(
        padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 80, 16, 0),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.75,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(event.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(99),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "🔥 ${event.interestedCount} Interested",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildContent(BuildContext context, EventModel event) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "UNIVERSITY CAMPUS • ${event.category.toUpperCase()}",
              style: const TextStyle(
                color: Color(0xFF241A7F),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              event.title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                height: 1.1,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 32),
            _buildInfoCard(
              icon: Icons.calendar_today,
              title: event.date,
              subtitle: "${event.time} (EDT)",
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              icon: Icons.location_on,
              title: event.location,
              subtitle: "Main Campus Zone",
              trailing: const Text(
                "Info",
                style: TextStyle(
                  color: Color(0xFF241A7F),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildOrganizerSection(event),
            const SizedBox(height: 32),
            const Text(
              "About the Event",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              event.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Read More",
              style: TextStyle(
                color: Color(0xFF241A7F),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            _buildQuickActions(),
          ],
        ),
      );

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
  }) =>
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF241A7F).withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF241A7F).withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFF241A7F),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      );

  Widget _buildOrganizerSection(EventModel event) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.group, color: Color(0xFF241A7F)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Organized by",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  Text(
                    event.organizer,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF241A7F),
                elevation: 0,
                side: const BorderSide(color: Color(0xFF241A7F)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: const Text("Follow", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );

  Widget _buildQuickActions() => Row(
        children: [
          _buildQuickActionItem(Icons.group_outlined, "Networking"),
          const SizedBox(width: 12),
          _buildQuickActionItem(Icons.restaurant_outlined, "Free Food"),
          const SizedBox(width: 12),
          _buildQuickActionItem(Icons.card_giftcard_outlined, "Swag Bag"),
        ],
      );

  Widget _buildQuickActionItem(IconData icon, String label) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, color: const Color(0xFF241A7F)),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );

  Widget _buildBottomBar(BuildContext context, EventModel event) => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).padding.bottom + 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            border: Border(top: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade200, width: 2),
                ),
                child: const Icon(Icons.event_note_outlined, color: Colors.grey),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () => FirebaseService().updateInterest(event.id),
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFF241A7F),
                      borderRadius: BorderRadius.circular(99),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF241A7F).withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.qr_code_scanner, color: Colors.white),
                        SizedBox(width: 12),
                        Text(
                          "Check-In Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
