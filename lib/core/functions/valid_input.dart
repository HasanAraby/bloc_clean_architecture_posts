validInput(String? val) {
  // if (val.length < min) {
  //   return "can't be less than $min";
  // }

  // if (val.length > max) {
  //   return "can't be larger than $max";
  // }

  if (val == null || val.isEmpty) {
    return "can't be empty";
  }
}
