import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker/common/validators.dart';

void main(){
  test("non empty string", (){
    final validators = NonEmptyStringValidator();
    expect(validators.isValid("test"), true);
  });

  test("empty string", (){
    final validators = NonEmptyStringValidator();
    expect(validators.isValid(""), false);
  });

  test("null string", (){
    final validators = NonEmptyStringValidator();
    expect(validators.isValid(null), false);
  });
}