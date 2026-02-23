import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../models/event_model.dart';
import '../widgets/event_card.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() => Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade100)),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_filled, 'Home', 0),
              _buildNavItem(Icons.person_outline, 'Profile', 1),
            ],
          ),
        ),
      );

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: isSelected
                ? BoxDecoration(
                    color: const Color(0xFF241A7F).withOpacity(0.1),
                    shape: BoxShape.circle,
                  )
                : null,
            child: Icon(
              icon,
              color: isSelected ? const Color(0xFF241A7F) : Colors.grey,
              size: 26,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? const Color(0xFF241A7F) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                _buildSearchBar(),
                _buildCategories(),
                _buildEventListHeader(),
                _buildEventList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() => Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF241A7F).withOpacity(0.1), width: 2),
                image: const DecorationImage(
                  image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCXaHZSNGxvDB5yoh6v6MsoZ-rQkb8W9NQqsXy74UZ-BVJRyXP_YDKhMnbGKNiMgQohQijyKSBJTJXoWtncLERE1GtjxdGXBFeLOUwbyM2PIauUlNpKq_Tna-p68wDsoQsEwR0PzDMr75AAtf1A5GtE7SQIJgPiG10nJgcvY9RmVraRAmL3y5X7hKf6lQ5sJ3bkG9Rz_7V5vvOeqmPpyNKHCCtaTDwVSDMsdRudZwXgIQw1BcfjwvwBGKwaMR7iYZhPxkw9pg5x74M'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "WELCOME BACK",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    "Hello, Alex",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF241A7F),
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
              child: IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black87),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
                },
              ),
            ),
          ],
        ),
      );

  Widget _buildSearchBar() => SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        sliver: SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(99),
              border: Border.all(color: Colors.grey.shade100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search events, clubs, workshops...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ),
      );

  Widget _buildCategories() {
    final categories = ['All', 'Tech', 'Sports', 'Arts', 'Social'];
    return SliverPadding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: categories.length,
            itemBuilder: (context, i) {
              final isSelected = selectedCategory == categories[i];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => setState(() => selectedCategory = categories[i]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF241A7F) : Colors.white,
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF241A7F) : Colors.grey.shade100,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(0xFF241A7F).withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        categories[i],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEventListHeader() => SliverPadding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        sliver: SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Featured Events",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedCategory = 'All';
                  });
                },
                child: const Text(
                  "See all",
                  style: TextStyle(color: Color(0xFF241A7F), fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildEventList() => StreamBuilder<List<EventModel>>(
        stream: FirebaseService().getEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
          }

          final events = snapshot.data!;
          final filteredEvents = selectedCategory == 'All'
              ? events
              : events.where((e) => e.category.toUpperCase() == selectedCategory.toUpperCase()).toList();

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: EventCard(key: ValueKey(filteredEvents[i].id), event: filteredEvents[i]),
              ),
              childCount: filteredEvents.length,
            ),
          );
        },
      );
}
