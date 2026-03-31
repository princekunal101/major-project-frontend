class PasswordStringValidator {
  // check String patterns
  bool hasUppercase(String s) => s.contains(RegExp(r'[A-Z]'));

  bool hasLowercase(String s) => s.contains(RegExp(r'[a-z]'));

  bool hasNumber(String s) => s.contains(RegExp(r'[0-9]'));

  bool hasSpecialCharacter(String s) => s.contains(RegExp(r'[@$#!%*?&]'));

  String? validatePassword(String password) {
    List<String> missing = [];

    final hasLower = hasLowercase(password);
    final hasUpper = hasUppercase(password);
    final hasNum = hasNumber(password);
    final hasSpecial = hasSpecialCharacter(password);

    if (password.length < 8) {
      return 'Password must be greater or equal to 8 characters';
    }

    if (!hasLower && !hasUpper && !hasNum && !hasSpecial) {
      return 'Password must contain at least one lowercase, one uppercase, one number and one special character.';
    }

    if (!hasLower) missing.add('one lowercase letter');
    if (!hasUpper) missing.add('one uppercase letter');
    if (!hasNum) missing.add('one number');
    if (!hasSpecial) missing.add('one special character');

    if (missing.isEmpty) return null;

    return 'Password must contain at least ${missing.join(' and ')}.';
  }
}
