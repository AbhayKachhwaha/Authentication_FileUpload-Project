RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

class Validator {
  static String? validateEmail({required String? email}) {
    if (email == null) return null;

    if (email.isEmpty) {
      return 'Email field can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) return null;

    if (password.isEmpty) return 'Password field can\'t be empty';

    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }

  static String? validateDescription(String? description) {
    if (description != null && description.length > 300) {
      return 'Please enter no more than 300 characters';
    }

    return null;
  }
}
