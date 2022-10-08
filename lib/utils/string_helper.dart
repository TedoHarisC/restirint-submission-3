bool parseStringtoBool(String text) {
  if (text.toLowerCase() == 'true') {
    return true;
  } else if (text.toLowerCase() == 'false') {
    return false;
  } else {
    return false;
  }
}
