part of nhabe;

/// common utilities

bool _isEqualDate(DateTime? d1, DateTime? d2) {
  if (d1 == null && d2 == null) {
    return true;
  } else if (d1 == null) {
    return false;
  } else if (d2 == null) {
    return false;
  }

  return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
}
