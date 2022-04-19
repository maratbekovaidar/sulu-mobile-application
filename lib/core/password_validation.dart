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

  final RegExp _upperCaseSymbols = RegExp(r'[A-Z]');
  final RegExp _lowerCaseSymbols = RegExp(r'[a-z]');
  final RegExp _digits = RegExp(r'[0-9]');
  final RegExp _symbols = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]');

}