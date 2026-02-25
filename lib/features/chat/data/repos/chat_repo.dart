import 'package:dartz/dartz.dart';
 import '../../../../core/errors/failure.dart';
import '../models/chat_models.dart';

abstract class ChatRepo {
  Future<Either<Failure, SendMessageModel>> sendMessage({
    required String message,
    required int teacherId,
  });
  Future<Either<Failure, AllMessagesModel>> getAllMessages({
    required int userId,
    required int teacherId,
  });
}
