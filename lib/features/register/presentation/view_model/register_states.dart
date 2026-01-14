import 'package:el_kottab_teacher_app/features/register/data/models/categories_model.dart';

import '../../data/models/register_model.dart';

abstract class RegisterStates {}

class RegisterInitState extends RegisterStates {}

class ChangeSuffixIconState extends RegisterStates {}

class ChangeSuffixIconState2 extends RegisterStates {}

class SignUpLoading extends RegisterStates {}

class SignUpSuccess extends RegisterStates {
  final RegisterModel registerModel;
  SignUpSuccess(this.registerModel);
}

class SignUpError extends RegisterStates {
  final String message;
  SignUpError(this.message);
}

class SelectGenderState extends RegisterStates {}

class GetAllCategoriesLoadingState extends RegisterStates {}

class GetAllCategoriesErrorState extends RegisterStates {
  final String error;
  GetAllCategoriesErrorState(this.error);
}

class GetAllCategoriesSuccessState extends RegisterStates {
  final CategoriesModel categoriesModel;
  GetAllCategoriesSuccessState(this.categoriesModel);
}

class CategorySelectedState extends RegisterStates {}

class RegisterPickFileState extends RegisterStates {}
