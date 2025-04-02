import 'package:ecommerce_flutter/Utils/Constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late IO.Socket socket;

  // Private constructor for singleton
  SocketService._internal();

  // Factory to return the singleton instance
  factory SocketService() {
    return _instance;
  }

  /// Connects to the Socket.IO server
  Future<void> connect(String token) async {
    // Socket.IO connection options
    final options = IO.OptionBuilder()
        .setTransports(
            ['websocket']) // Use WebSocket for real-time communication
        .setExtraHeaders({'Authorization': token}) // Pass JWT token
        .disableAutoConnect() // Prevent automatic connection
        .build();

    // Create socket instance
    socket = IO.io(Constants.api, options);

    // Attach connection listeners
    socket.onConnect((_) {
      print('Connected to Socket.IO server');
    });

    socket.onConnectError((error) {
      print('Connection error: $error');
    });

    socket.onDisconnect((_) {
      print('Disconnected from Socket.IO server');
    });

    // Connect to the server
    socket.connect();
  }

  /// Emit an event to the server
  void emit(String event, dynamic data) {
    socket.emit(event, data);
  }

  /// Listen to an event from the server
  void on(String event, Function(dynamic) callback) {
    socket.on(event, callback);
  }

  /// Disconnect from the server
  void disconnect() {
    socket.disconnect();
  }
}
