import 'package:dio/dio.dart';
import '../models/room.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3000',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  // ==========================
  // CREATE ROOM
  // ==========================
  Future<Room> createRoom(String username) async {
    try {
      final response = await _dio.post(
        '/rooms',
        data: {
          'username': username,
        },
      );

      return Room.fromJson(response.data['room']);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Failed to create room',
      );
    }
  }

  // ==========================
  // JOIN ROOM
  // ==========================
  Future<Room> joinRoom(int roomCode, String username) async {
    try {
      final response = await _dio.post(
        '/rooms/$roomCode/join',
        data: {
          'username': username,
        },
      );

      return Room.fromJson(response.data['room']);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Failed to join room',
      );
    }
  }
}