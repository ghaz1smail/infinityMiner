import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'email': 'Email',
          'name': 'Name',
          'back': 'Back',
          'reset_password': 'Reset Password',
          'please_enter_your_name': 'Please enter your name',
          'password': 'Password',
          'log_in': 'Log In',
          'forgot_password': 'Forgot Password?',
          'dont_have_an_account': 'Dont Have An Account?',
          'sign_up': 'Sign Up',
          'already_have_an_account': 'Already Have An Account?',
          'please_enter_a_valid_email': 'Please Enter a valid email',
          'password_length_should_at_least_6_character':
              'Password length should at least 6 characters',
          'error_occured': 'Error occurred',
        },
      };
}
