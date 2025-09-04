class Customformat {
  static String formatCurrency(double amount) {
    return amount
        .toStringAsFixed(2)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  static String formatDate({required DateTime time, bool dateOnly = false}) {
    String year = time.year.toString();

    // Add "0" on the left if month is from 1 to 9
    String month = time.month.toString().padLeft(2, '0');

    // Add "0" on the left if day is from 1 to 9
    String day = time.day.toString().padLeft(2, '0');

    // Add "0" on the left if hour is from 1 to 9
    String hour = time.hour.toString().padLeft(2, '0');

    // Add "0" on the left if minute is from 1 to 9
    String minute = time.minute.toString().padLeft(2, '0');

    // Add "0" on the left if second is from 1 to 9
    String second = time.second.toString();

    // If you only want year, month, and date
    if (dateOnly == false) {
      return "$day-$month-$year $hour:$minute:$second";
    }

    // return the "yyyy-MM-dd HH:mm:ss" format
    return "$day-$month-$year";
  }
}
