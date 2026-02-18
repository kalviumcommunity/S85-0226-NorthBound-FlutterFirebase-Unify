# CampusHub: The Unified Student Engagement Platform :

## 🚩 The Problem: "The Digital Chaos of Campus Life"

Currently, college ecosystems suffer from **information fragmentation**. Clubs and student communities operate in silos, leading to:

* **Communication Fatigue:** Students are forced to juggle WhatsApp groups, Discord servers, Telegram channels, and Instagram stories just to stay updated.
* **Invisible Events:** High-quality workshops and fests often go unattended simply because the announcement was buried under 500 other messages.
* **Logistical Nightmares:** Organizers manually track registrations via Google Forms and mark attendance on paper sheets, leading to data loss and delayed certificate distribution.
* **Lack of Accountability:** Without a centralized system, there is no verified record of a student’s extracurricular participation.

---

## 💡 The Solution: A Single Source of Truth

**CampusHub** replaces the noise with a streamlined, "one-stop-shop" for everything happening on campus.

* **For Students:** A personalized feed to discover events, register with one click, and maintain a digital portfolio of their participation.
* **For Club Leads:** A powerful management suite to post announcements, track real-time registration counts, and broadcast updates instantly.
* **For Administrators:** A bird’s-eye view of campus activity, allowing for easy event approval and automated, verified attendance via QR codes.

---

## 🛠️ From Vision to Code: The Tech Stack

We bridge the gap between "frustration" and "function" using a robust, scalable architecture:

| Feature | Technical Implementation |
| --- | --- |
| **Unified Interface** | Developed using **React.js** (Web) and **Flutter** (Mobile) for a seamless, cross-platform experience. |
| **Real-time Sync** | **WebSockets/Django Channels** ensure that a "Sold Out" event or an emergency venue change is reflected instantly across all devices. |
| **Secure Access** | A **3-Tier Role-Based Access Control (RBAC)** system built with **Django Rest Framework** to separate Admin, Organizer, and Student permissions. |
| **Data Integrity** | **PostgreSQL** handles complex relationships between clubs, events, and attendees, while **Redis** manages high-speed caching for trending events. |
| **Attendance** | Unique **QR Code generation** and scanning logic to automate check-ins and trigger automated certificate emails via **SMTP/AWS SES**. |

---

## 👥 The Team

This project was conceptualized and built by:

* **Nikunj Kohli**
* **Shivang Gautam**
* **Subhadeep Samanta**


