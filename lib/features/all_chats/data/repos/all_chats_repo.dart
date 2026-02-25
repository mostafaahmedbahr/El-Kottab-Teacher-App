import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/all_chats_model.dart';

abstract class AllChatsRepo {

  Future<Either<Failure, AllChatsModel>> getAllChats();

}
