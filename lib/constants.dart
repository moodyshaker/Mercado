final String emailErrorMsg = 'Please enter valid email';
final String passwordErrorMsg = 'Please enter at least 6 digits';
final String passwordNotMatchErrorMsg =
    'Your password doesn\'t match each others';
final String fullNameErrorMsg = 'please enter proper username';
final String googleAuthPassword = '%Ahmed%mercado';
final String facebookAuthPassword = '%Ahmed%mercado';
final String baseUrl = 'https://memmaas-61afb.firebaseio.com/';

enum AccountState {
  REGISTER,
  NOT_FOUND,
}

enum NetworkState {
  NO_CONNECTION,
  STABLE_CONNECTION,
}
