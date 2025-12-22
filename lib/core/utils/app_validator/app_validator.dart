 //
import 'package:easy_localization/easy_localization.dart';

import '../../../lang/lang_keys.dart';

class AppValidators {
  static String? displayNameValidator(String? displayName) {
    if (displayName == null || displayName.trim().isEmpty) {
      return LangKeys.nameValidate.tr(); // "Name is required"
    }

    final trimmed = displayName.trim();

    if (trimmed.length < 2) {
      return LangKeys.nameTooShort.tr(); // "Name must be at least 2 characters"
    }

    if (trimmed.length > 50) {
      return LangKeys.nameTooLong.tr(); // "Name cannot exceed 50 characters"
    }

    if (RegExp(r'[0-9]').hasMatch(trimmed)) {
      return LangKeys.nameNoNumbers.tr(); // "Name cannot contain numbers"
    }

    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(trimmed)) {
      return LangKeys.nameNoSpecialChars.tr(); // "Name cannot contain special characters"
    }

    return null;
  }

  static String? displayMessageValidator(String? message) {
    if (message == null || message.isEmpty) {
      return LangKeys.messageValidate.tr(); // "Message is required"
    }

    if (message.length < 10) {
      return LangKeys.messageTooShort.tr(); // "Message must be at least 10 characters"
    }

    if (message.length > 500) {
      return LangKeys.messageTooLong.tr(); // "Message cannot exceed 500 characters"
    }

    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LangKeys.emailValidate.tr(); // "Email is required"
    }

    final emailRegex = RegExp(
        r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$'
    );

    if (!emailRegex.hasMatch(value)) {
      return LangKeys.emailValidate2.tr(); // "Please enter a valid email"
    }

    // Additional checks for common email issues
    if (value.contains(' ')) {
      return LangKeys.emailNoSpaces.tr(); // "Email cannot contain spaces"
    }

    if (value.startsWith('.') || value.endsWith('.')) {
      return LangKeys.emailInvalidDots.tr(); // "Email cannot start or end with a dot"
    }

    if ('@.'.allMatches(value).length > 1) {
      return LangKeys.emailMultipleAt.tr(); // "Email can only contain one @ symbol"
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LangKeys.passwordValidate.tr(); // "Password is required"
    }

    // Detailed password requirements
    final requirements = <String>[];

    if (value.length < 8) {
      requirements.add(LangKeys.passwordMinLength.tr()); // "8 characters minimum"
    }

    if (value.length > 30) {
      requirements.add(LangKeys.passwordMaxLength.tr()); // "30 characters maximum"
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      requirements.add(LangKeys.passwordRequireUppercase.tr()); // "1 uppercase letter"
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      requirements.add(LangKeys.passwordRequireLowercase.tr()); // "1 lowercase letter"
    }

    if (!RegExp(r'\d').hasMatch(value)) {
      requirements.add(LangKeys.passwordRequireNumber.tr()); // "1 number"
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      requirements.add(LangKeys.passwordRequireSpecial.tr()); // "1 special character"
    }

    if (requirements.isNotEmpty) {
      return '${LangKeys.passwordRequirements.tr()}:\n${requirements.join('\n')}';
    }

    return null;
  }

  static String? urlValidator(String? value, {bool isRequired = false}) {
    if (isRequired && (value == null || value.isEmpty)) {
      return LangKeys.urlRequired.tr(); // "URL is required"
    }

    if (value == null || value.isEmpty) {
      return null;
    }

    final urlRegex = RegExp(
        r'^(https?://)?' // http:// or https://
        r'([\w-]+\.)+[\w-]+' // Domain
        r'(:\d+)?' // Port
        r'(/[\w-./?%&=]*)?$' // Path and query
    );

    if (!urlRegex.hasMatch(value)) {
      return LangKeys.urlInvalid.tr(); // "Please enter a valid URL"
    }

    if (!value.startsWith('http://') && !value.startsWith('https://')) {
      return LangKeys.urlMissingProtocol.tr(); // "URL must start with http:// or https://"
    }

    return null;
  }

  static String? repeatPasswordValidator({String? value, String? password}) {
    if (value == null || value.isEmpty) {
      return LangKeys.repeatPasswordRequired.tr() ;// "Please repeat your password"
    }

    if (password == null || password.isEmpty) {
      return LangKeys.enterPasswordFirst.tr(); // "Please enter your password first"
    }

    if (value != password) {
      return LangKeys.passwordsDontMatch.tr(); // "Passwords don't match"
    }

    return null;
  }

  static String? phoneValidator(String? value, {String? countryCode}) {
    if (value == null || value.isEmpty) {
      return LangKeys.phoneRequired.tr(); // "Phone number is required"
    }

    final numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');

    // Country-specific validation
    switch (countryCode) {
      case '+20': // Egypt
        if (!RegExp(r'^01[0-9]{9}$').hasMatch(numericValue)) {
          return LangKeys.phoneEgyptInvalid.tr();
         // "Egyptian numbers must be 11 digits starting with 01"
        }
        break;
      case '+1': // US/Canada
        if (numericValue.length != 10) {
          return LangKeys.phoneUSInvalid.tr();
           // "US/Canada numbers must be 10 digits"
        }
        break;
      default: // International
        if (numericValue.length < 8 || numericValue.length > 15) {
          return LangKeys.phoneInternationalInvalid.tr();
         // "Phone number must be 8-15 digits"
        }
    }

    return null;
  }
}