# TCFC App

Android mobile app for **Telugu Christian Fellowship Church VA** (Ashburn, VA) — built with Flutter and Firebase.

## Features

- **Home** — Church schedule, upcoming events, Sunday service info, 2026 promise verse, social links
- **Events** — Calendar view with real-time Firestore events; leaders can add, edit, and delete events (multi-day support)
- **Prayer** — Submit prayer requests; leaders see a private inbox and can mark prayers answered
- **Ministries** — Ministry directory with leader info, descriptions, and contact emails; role-based member management for leaders

## Tech Stack

| Layer | Technology |
|-------|-----------|
| UI | Flutter (Dart) |
| Auth | Firebase Authentication (email/password) |
| Database | Cloud Firestore (real-time streams) |
| State | Provider |
| Calendar | table_calendar |

## User Roles

| Role | Access |
|------|--------|
| Guest | Home, Events, public prayers — no login required |
| Member | Guest + submit prayer requests |
| Leader | Member + add/edit/delete events, private prayer inbox, manage member roles |

Leaders are flagged via a `role: "leader"` field in their Firestore user document.

## Getting Started

### Prerequisites

- Flutter SDK 3.11+
- Firebase project with Auth and Firestore enabled
- Android device or emulator

### Setup

```bash
git clone https://github.com/ebhatt/tcfc-app.git
cd tcfc-app
flutter pub get
```

Add your `google-services.json` to `android/app/` from the Firebase console, then:

```bash
flutter run
```

### Build APK

```bash
flutter build apk --release
```

## Project Structure

```
lib/
├── constants.dart          # Church info, ministries, schedule
├── theme.dart              # Warm gold theme (#b45309)
├── models/                 # Event, PrayerRequest, AppUser
├── services/               # Firestore + Auth service layer
├── providers/              # AuthProvider (ChangeNotifier)
├── screens/
│   ├── home/
│   ├── events/
│   ├── prayer/
│   └── more/               # Ministries + admin
└── widgets/                # EventCard, PrayerCard
```

## Design

- **Theme:** Warm Gold — Primary `#b45309`, Accent `#d97706`, Background `#fffbf0`
- **Platform:** Android (Flutter codebase is iOS-ready)
- **Backend:** Firebase Spark (free tier) — no server to manage

## Deployment

1. Debug APK — sideload for testing
2. Firebase App Distribution — share with church leaders
3. Google Play Store — public release to congregation

---

Built for [TCFC VA](https://www.tcfcva.com) · Ashburn, Virginia
