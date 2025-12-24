
// name
String? validateName(String? value) {
  if (value == null) {
    return 'Name is required';
  }
  if (value.trim().isEmpty) {
    return 'Name cannot be empty';
  }
  if (value.length < 4) {
    return 'Name must be at least 4 characters';
  }
  if (value.length > 50) {
    return 'Name must be less than 50 characters';
  }
  if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(value)) {
    return 'Name contains invalid characters';
  }
  return null;
}

// email
String? validateEmail(String? value) {
  if (value == null) {
    return 'Email is required';
  }
  if (value.trim().isEmpty) {
    return 'Email cannot be empty';
  }
  if (value.length > 100) {
    return 'Email must be less than 100 characters';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(value)) {
    return 'Invalid email address';
  }
  return null;
}

// phone
String? validatePhone(String? value) {
  if (value == null) {
    return 'Phone number is required';
  }
  if (value.trim().isEmpty) {
    return 'Phone number cannot be empty';
  }
  if (!RegExp(r'^\+?\d{6,15}$').hasMatch(value)) {
    return 'Phone number must be between 6 and 15 digits and contain only numbers';
  }
  return null;
}

// password
String? validatePassword(String? value) {
  if (value == null) {
    return 'Password is required';
  }
  if (value.isEmpty) {
    return 'Password cannot be empty';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  if (value.length > 50) {
    return 'Password must be less than 50 characters';
  }
  if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!@#\$&*~]{6,}$').hasMatch(value)) {
    return 'Password must contain at least one letter and one number';
  }
  return null;
}

// message
String? validateMessage(String? value) {
  if (value == null) {
    return 'Message is required';
  }
  if (value.trim().isEmpty) {
    return 'Message cannot be empty';
  }
  if (value.length < 10) {
    return 'Message must be at least 10 characters';
  }
  if (value.length > 500) {
    return 'Message must be less than 500 characters';
  }
  return null;
}

// positive
String? validatePositiveNumber(String? value) {
  if (value == null) {
    return 'Number is required';
  }
  if (value.trim().isEmpty) {
    return 'Number cannot be empty';
  }
  final number = double.tryParse(value);
  if (number == null) {
    return 'Please enter a valid number';
  }
  if (number < 0) {
    return 'Number must be positive';
  }
  if (number.isInfinite || number.isNaN) {
    return 'Number is not valid';
  }
  return null;
}

// positive int
String? validatePositiveIntNumber(String? value) {
  if (value == null) {
    return 'Number is required';
  }
  if (value.trim().isEmpty) {
    return 'Number cannot be empty';
  }
  final number = int.tryParse(value);
  if (number == null) {
    return 'Please enter a valid integer';
  }
  if (number < 0) {
    return 'Number must be positive';
  }
  if (number > 1000000000) {
    return 'Number is too large';
  }
  return null;
}