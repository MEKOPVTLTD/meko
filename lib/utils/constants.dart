RegExp EMAIL_REGEX = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
RegExp NAME_REGEX = RegExp(r'^[a-z A-Z]+$');
RegExp PHONE_NUMBER_REGEX = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
RegExp ADDRESS_REGEX = RegExp(r'^[a-z A-Z 0-9 \[!@#$%^&*(),.?":{}|<>\]]+$');
RegExp PASSWORD_REGEX = RegExp(r'^[a-z A-Z 0-9 \[!@#$%^&*(),.?":{}|<>\]]+$');