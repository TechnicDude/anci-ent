class AppValidator {
  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return "please enter email address  ";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value.trim())) {
      return "please enter a valid email address";
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "please enter your password ";
    } else if (value.length < 5) {
      return "Password must be at least 6 characters in length";
    }
    return null;
  }

  static String? confirm_passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "please enter confirm password ";
    } else if (value.length < 5) {
      return "Password must be same";
  }
    return null;
  }

  static String? nameValidator(String? value) {
    if (value!.isEmpty) {
      return "please enter your name ";
    } else if (value.length < 3) {
      return "please enter name at least 4 digit ";
    }
    return null;
  }

  static String? emptyValidator(String? value) {
    if (value!.isEmpty) {
      return "please enter some text ";
    }
    return null;
  }
}
