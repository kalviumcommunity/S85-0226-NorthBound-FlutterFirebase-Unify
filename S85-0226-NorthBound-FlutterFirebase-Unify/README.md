# Unify: The Unified Student Engagement Platform

## 🚩 The Problem: "The Digital Chaos of Campus Life"

Currently, college ecosystems suffer from **information fragmentation**. Clubs and student communities operate in silos, leading to:
* **Communication Fatigue:** Juggling WhatsApp, Discord, Telegram, and Instagram for updates.
* **Invisible Events:** High-quality workshops go unattended because announcements are buried.
* **Logistical Nightmares:** Manual registration (Google Forms) and paper-based attendance.
* **Lack of Accountability:** No verified record of extracurricular participation.

## 💡 The Solution: A Single Source of Truth

**Unify** is a streamlined, "one-stop-shop" for everything happening on campus.
* **For Students:** Personalized feed, one-click registration, and a digital participation portfolio.
* **For Club Leads:** Management suite to post events, track real-time registrations, and broadcast updates.
* **For Administrators:** Campus activity overview, event approval, and automated QR-based attendance.

## 🚀 Current Implementation Status

The project is currently in active development with the following core modules:

### 📱 Features Built
*   **Authentication:** Email/Password login and signup via Firebase Auth.
*   **Event Discovery:** Real-time event feed from Firestore with category filtering.
*   **Event Interaction:** 
    *   **Check-In/Check-Out:** Users can mark interest in events (increments/decrements public count).
    *   **Saved Events:** Persistent list of events a user is interested in (Firestore-backed).
*   **Navigation:** Clean UI with Home, Saved, Notifications, and Profile views.
*   **Real-time Updates:** Uses `Streams` for instant UI updates when data changes in Firestore.

### 🛠️ Tech Stack
*   **Frontend:** Flutter (Dart) with Material 3.
*   **Backend:** Firebase (Auth, Firestore).
*   **State Management:** Reactive programming using Streams and `StreamBuilder`.
*   **Local Storage:** `shared_preferences` (used for local bookmarks/preferences).

## 🔮 Future Optimized Plans (Roadmap)

To move from a prototype to a production-ready campus tool, the following enhancements are planned:

### 1. Architectural Improvements
*   **Global State Management:** Migrate from inline `StreamBuilder` to a robust state management solution like **Provider** or **Riverpod** for better scalability and testability.
*   **Service Layer Abstraction:** Decouple Firestore logic from the UI completely using a Repository pattern.

### 2. High-Impact Features
*   **QR-Based Attendance:** Generate unique QR codes for registered students; organizers can scan to verify attendance.
*   **Role-Based Access (RBAC):** Implement specific UI/UX for "Organizers" to create/edit events directly from the app.
*   **Push Notifications:** Integration with Firebase Cloud Messaging (FCM) for event reminders and urgent announcements.
*   **Image Optimization:** Implement Cloudinary or Firebase Storage with a caching layer (like `cached_network_image`) for faster media loading.

### 3. User Experience (UX)
*   **Offline Support:** Implement Firestore offline persistence and a local cache strategy to ensure the app works in low-connectivity areas on campus.
*   **Calendar Integration:** Allow users to sync registered events directly to their Google/Outlook calendars.
*   **Dark Mode:** Full support for system-wide dark theme.

## 👥 The Team
* **Nikunj Kohli**
* **Shivang Gautam**
* **Subhadeep Samanta**
