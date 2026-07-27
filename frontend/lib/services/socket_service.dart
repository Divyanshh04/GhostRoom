import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() => _instance;

  SocketService._internal();

  late io.Socket socket;

  void connect() {
    socket = io.io(
      "http://10.0.2.2:3000",
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print("✅ Socket Connected");
    });

    socket.onDisconnect((_) {
      print("❌ Socket Disconnected");
    });

    socket.onConnectError((data) {
      print("Connect Error: $data");
    });

    socket.onError((data) {
      print("Socket Error: $data");
    });
  }

  void joinRoom({
    required int roomCode,
    required String userId,
    required String username,
  }) {
    socket.emit("join-room", {
      "roomCode": roomCode,
      "userId": userId,
      "username": username,
    });
  }

  void sendMessage(String message) {
    socket.emit("send-message", {
      "message": message,
    });
  }

  void onReceive(Function(dynamic) callback) {
    socket.on("receive-message", callback);
  }

  void onUserJoined(Function(dynamic) callback) {
    socket.on("user-joined", callback);
  }

  void onUserLeft(Function(dynamic) callback) {
    socket.on("user-left", callback);
  }

  void onErrorMessage(Function(dynamic) callback) {
    socket.on("error-message", callback);
  }

  void onParticipantCount(Function(dynamic) callback) {
  socket.on("participant-count", callback);
}

  void dispose() {
    socket.dispose();
  }
}