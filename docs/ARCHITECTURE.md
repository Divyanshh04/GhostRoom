# GhostRoom Architecture

## Frontend

Flutter application.

Responsibilities:
- Create Room
- Join Room
- Display Chat
- Send Messages
- Receive Messages

---

## Backend

Node.js + Express + Socket.IO

Responsibilities:
- Generate Room Codes
- Create Rooms
- Store Active Rooms
- Forward Messages
- Delete Expired Rooms

---

## Storage

Redis (later)

Stores:
- Active Rooms
- Participants
- Expiration Time

Messages are NOT stored permanently.

---

## Design Principles

- Privacy First
- No Accounts
- Temporary Rooms
- No Permanent Chat History
- End-to-End Encryption (future)