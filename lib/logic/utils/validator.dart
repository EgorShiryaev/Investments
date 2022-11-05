const _empty = 'Поле обязательно для заполнения';

String? validateEmailField(String? value) {
  if (value == null || value == '') {
    return _empty;
  }
  final emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  if (!emailRegExp.hasMatch(value)) {
    return 'Поле несоответствует формату name@mail.com';
  }
  return null;
}

String? validateFullNameField(String? value) {
  if (value == null || value == '') {
    return _empty;
  }

  return null;
}

String? validatePasswordField(String? value) {
  if (value == null || value == '') {
    return _empty;
  }

  if (value.length < 8) {
    return 'Пароль должен быть не менее 8 символов';
  }

  final regEx = RegExp('^[a-zA-Z0-9]');
  if (!regEx.hasMatch(value)) {
    return 'Пароль должен состоять из латинских букв и цифр';
  }
  return null;
}

String? validateConfirmPasswordfField(String? value, String password) {
  if (value == null || value == '') {
    return _empty;
  }

  if (value != password) {
    return 'Пароли не совпадают';
  }

  return null;
}
