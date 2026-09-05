# 👻 GhostRoom

> A real-time anonymous chat application where users can create or join temporary rooms and communicate instantly.

GhostRoom is a full-stack real-time chat application built using **Flutter, Node.js, Express, Socket.IO, and Redis**.

The application allows users to create temporary chat rooms, join existing rooms using a room code, and communicate with other participants in real time.

---

## ✨ Features

- 🔐 Anonymous chat experience
- 🏠 Create temporary chat rooms
- 🔢 Join rooms using a unique room code
- 👥 Support for multiple participants per room
- 💬 Real-time messaging using Socket.IO
- 📊 Live participant count
- 🚪 User join and leave events
- 🔄 Automatic participant removal on disconnect
- ⏳ Temporary rooms with expiration logic
- 📱 Cross-platform Flutter application
- ☁️ Backend deployed using Railway
- 🗄️ Redis integration for backend infrastructure

---

## 🛠️ Tech Stack

### Frontend

- Flutter
- Dart
- Socket.IO Client

### Backend

- Node.js
- Express.js
- Socket.IO

### Database / Infrastructure

- Redis
- Railway

---

## 📂 Project Structure

```text
GhostRoom/
│
├── frontend/                  # Flutter application
│   ├── lib/
│   │   ├── screens/
│   │   ├── services/
│   │   ├── widgets/
│   │   └── main.dart
│   │
│   └── pubspec.yaml
│
├── backend/                   # Node.js backend
│   ├── src/
│   │   ├── config/
│   │   ├── controllers/
│   │   ├── data/
│   │   ├── routes/
│   │   ├── services/
│   │   ├── sockets/
│   │   ├── app.js
│   │   └── server.js
│   │
│   └── package.json
│
└── README.md
