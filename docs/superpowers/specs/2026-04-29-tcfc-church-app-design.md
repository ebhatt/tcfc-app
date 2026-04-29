# TCFC Mobile App — Design Spec
**Date:** 2026-04-29  
**Church:** Telugu Christian Fellowship Church VA (TCFC)  
**Website:** https://www.tcfcva.com/  
**Platform:** Android (Flutter, iOS-ready)

---

## Overview

A mobile app for TCFC's congregation in Ashburn, VA. The app surfaces key church information, an event calendar managed by church leaders, and a prayer request system. Built with Flutter and Firebase so it can expand to iOS with minimal rework.

---

## Tech Stack

| Layer | Technology | Reason |
|-------|-----------|--------|
| UI framework | Flutter (Dart) | Single codebase for Android + future iOS |
| Authentication | Firebase Auth — email/password | Simple, no extra server code |
| Database | Cloud Firestore | Real-time updates, offline support |
| Push notifications | Firebase Cloud Messaging | Free, native Android integration |
| Backend hosting | Firebase (Spark free tier) | No server to manage; free for church scale |

**Deployment path:**
1. Debug APK → sideload on device for demo
2. Firebase App Distribution → share with church leaders for testing
3. Google Play Store ($25 one-time) → public release to congregation

---

## Visual Design

**Theme:** Warm Gold  
**Primary color:** Amber/brown (`#b45309`)  
**Accent:** Gold (`#d97706`)  
**Background:** Warm off-white (`#fffbf0`)  
**Cards:** White with gold border (`#fde68a`)  
**Typography:** Sans-serif, clean hierarchy

---

## User Roles

| Role | Access | How Assigned |
|------|--------|-------------|
| Guest | View home, events, public prayers (no login required) | Default |
| Member | Guest + submit prayer requests | Email/password sign-up |
| Leader | Member + add/delete events, view private prayers | Admin sets `role: leader` in Firestore console |

Leaders are identified by a `role` field in their Firestore user document. The `+` add button on Events and the private prayer inbox are conditionally shown based on this field.

---

## App Structure

Bottom navigation bar with 4 tabs, visible to all users.

```
[ Home ]  [ Events ]  [ Prayer ]  [ More ]
```

### Tab 1 — Home
- Church name and tagline
- Sunday service info: 10:30 AM, In-Person & Online
- Address: 21740 Beaumeade Circle, Suite 115, Ashburn, VA 20147
- "Get Directions" button (opens Google Maps)
- "Watch Live" button (opens YouTube @tcfcva)
- Social media links: Facebook (tcfchurchva), Instagram (tcfcva), YouTube (@tcfcva)

### Tab 2 — Events
- Mini monthly calendar at top; selected day highlights in amber
- Scrollable list of upcoming events below calendar
- Each event card shows: title, date, time, location
- Tap event → detail screen with full description
- **Leaders only:** floating `+` button to add a new event; swipe-to-delete on event cards
- **Guests/Members:** read-only view

### Tab 3 — Prayer Requests
- List of public prayer requests from the congregation
- Each card shows: requester name, request text, timestamp, 🙏 praying count
- Authenticated members can tap 🙏 to indicate they are praying (increments count); guests are prompted to sign in
- `+` button → Submit Prayer Request screen (requires login; guests are prompted to sign in)
- **Submit screen fields:**
  - Prayer request text (multi-line)
  - Visibility toggle: "Share with congregation" (public) or "Private — leaders only"
- **Leaders only:** can see a separate "Private Requests" section with requests sent to leaders only

### Tab 4 — More
- **Ministries** — list of all 10 ministries with leader name and description
  - Pastoral (Rev. Rufus Bhimanapalli), Men's (Kiran Vukanti), Women's (Swapna Joe), Worship (Christina Choppala), Kids' (Kamal Telagathoti), Prayer (Sohini Davuluri), Discipleship (Yesusdas & Deepika), Outreach (John Stephen Meeniga), Ushering (Vani Willson), Media (Samson Rentapalli)
- **Give** — links to Vanco online portal (https://secure.myvanco.com/L-ZJBH/campaign/C-14K5E) and Zelle (Treasurer@tcfcva.com)
- **Contact** — email: connect@tcfcva.com, address
- **Sign In / Sign Out** — email/password auth; sign-up creates a Member account

---

## Data Model (Firestore)

### `users/{uid}`
```
displayName: string
email: string
role: "member" | "leader"
createdAt: timestamp
```

### `events/{eventId}`
```
title: string
date: timestamp
time: string          // e.g. "10:30 AM"
description: string
location: string
createdBy: uid
createdAt: timestamp
```

### `prayerRequests/{requestId}`
```
text: string
authorName: string
authorUid: uid
visibility: "public" | "private"
prayingCount: number
prayingUids: array<uid>   // to prevent double-counting
timestamp: timestamp
```

---

## Security Rules (Firestore)

- **events:** Anyone can read. Only users with `role == "leader"` can write.
- **prayerRequests (public):** Anyone can read public requests. Authenticated users can create. Authors can delete their own.
- **prayerRequests (private):** Only leaders and the author can read.
- **users:** Users can read/write their own document. Leaders can read all.

---

## Out of Scope for v1

- In-app giving/payments (links to external Vanco/Zelle only)
- Push notifications (Firebase Cloud Messaging wired up later)
- Sermon archive / YouTube integration (YouTube link on Home is sufficient for v1)
- Member directory
- Children's check-in
- iOS build (same codebase, separate deployment step)
