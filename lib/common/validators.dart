abstract class StringValidator{
  bool isValid(String text);
}

class NonEmptyStringValidator extends StringValidator{

  @override isValid(String text) {
    if(text == null){
      return false;
    }
    return text.isNotEmpty;
  }
}

class EmailAndPasswordValidator {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String emailErrorText = "Email should not be empty";
  final String passwordErrorText = "Password should not be empty";
}
