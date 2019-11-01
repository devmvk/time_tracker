
import 'package:flutter/services.dart';
import 'package:time_tracker/common/platform_alert_dialog.dart';
import 'package:meta/meta.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog{
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super(
    title : title,
    content: _message(exception),
    defalutActionText: "OK"
  );

  static String _message(PlatformException exception) => exception.message;
}


Map<String, String> _errors = {
  /// Errors:
  ///   • `ERROR_INVALID_CREDENTIAL` - If the credential data is malformed or has expired.
  ///   • `ERROR_USER_DISABLED` - If the user has been disabled (for example, in the Firebase console)
  ///   • `ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL` - If there already exists an account with the email address asserted by Google.
  ///       Resolve this case by calling [fetchSignInMethodsForEmail] and then asking the user to sign in using one of them.
  ///       This error will only be thrown if the "One account per email address" setting is enabled in the Firebase console (recommended).
  ///   • `ERROR_OPERATION_NOT_ALLOWED` - Indicates that Google accounts are not enabled.
  ///   • `ERROR_INVALID_ACTION_CODE` - If the action code in the link is malformed, expired, or has already been used.
  ///       This can only occur when using [EmailAuthProvider.getCredentialWithLink] to obtain the credential.
  ///   • `ERROR_INVALID_CUSTOM_TOKEN` - The custom token format is incorrect.
  ///     Please check the documentation.
  ///   • `ERROR_CUSTOM_TOKEN_MISMATCH` - Invalid configuration.
  ///     Ensure your app's SHA1 is correct in the Firebase console.

};