validInput(String val, int min, int max, String type) {
  if (val.length < min) {
    return "can't be less than $min";
  }

  if (val.length > max) {
    return "can't be larger than $max";
  }

  if (val.isEmpty) {
    return "can't be empty";
  }
}
