RegExp EMAIL_REGEX = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
RegExp NAME_REGEX = RegExp(r'^[a-z A-Z]+$');
RegExp PHONE_NUMBER_REGEX = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
RegExp ADDRESS_REGEX = RegExp(r'^[a-z A-Z 0-9 \[!@#$%^&*(),.?":{}|<>\]]+$');
RegExp PASSWORD_REGEX = RegExp(r'^[a-z A-Z 0-9 \[!@#$%^&*(),.?":{}|<>\]]+$');

const String LOCATION_PERMISSION_DENIED = "Location permissions are denied";
const String LOCATION_PERMISSION_PERMANENT_DENIED =
    "Location permissions are permanently denied, we cannot request permissions.";
const String LOCATION_SERVICE_DISABLED =
    "Location services are disabled. Please enable";
const String ENABLE_APP_LOCATION_MSG = "Enable App Location";
const String ENABLE_LOCATION_MSG = "Enable Location";
const String OK = "OK";
const String LOADING_ADDRESS = "Loading Address...";
const String SAVING_ADDRESS = "Saving Address...";
const String SAVE = "Save";
const String YOUR_ADDRESS = "Your Address";
