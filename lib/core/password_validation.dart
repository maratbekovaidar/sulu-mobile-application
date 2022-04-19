/// **Validator must have: **
///
/// * IoC
/// * Must expandable
/// * Must have customizer
/// * Have upper case text
/// * Have number
/// * Have lower case
/// * Have digits
/// * Have max and min password size
/// * Have constructor of template exception
class PasswordValidation {

  PasswordValidation({
    this.upperCaseValidate = false,
    this.lowerCaseValidate = false,
    this.digitCaseValidate = false,
    this.symbolsCaseValidate = false
  });

  final bool upperCaseValidate;
  final bool lowerCaseValidate;
  final bool digitCaseValidate;
  final bool symbolsCaseValidate;

  final RegExp _upperCaseSymbols = RegExp(r'[A-Z]');
  final RegExp _lowerCaseSymbols = RegExp(r'[a-z]');
  final RegExp _digits = RegExp(r'[0-9]');
  final RegExp _symbols = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]');

  String? validatePassword(String password) {

    if(upperCaseValidate) {
      return _upperCaseSymbols.hasMatch(password) ? "Password must have uppercase characters" : null;
    }

    if(lowerCaseValidate) {
      return _lowerCaseSymbols.hasMatch(password) ? "Password must have lowercase characters" : null;
    }

    if(digitCaseValidate) {
      return _digits.hasMatch(password) ? "Password must have digits" : null;
    }

    if(symbolsCaseValidate) {
      return _symbols.hasMatch(password) ? "Password must have symbols" : null;
    }

    return null;
  }

}