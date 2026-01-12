import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/all_messages_model.dart';
import '../models/send_message_model.dart';

abstract class ChatRepo{

  Future<Either<Failure,SendMessageModel>> sendMessage({required String message , required int teacherId});
  Future<Either<Failure,AllMessagesModel>> getAllMessages({required int userId , required int teacherId});




}