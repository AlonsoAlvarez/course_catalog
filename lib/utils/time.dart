class Time {
  static String date(DateTime dateTime) {
    return '${dateTime.day} ${_month(dateTime.month)} ${dateTime.year}';
  }

  static String hour(DateTime dateTime) {
    return " ${dateTime.hour}:" + _addCero(dateTime.minute);
  }

  static String dateTimeFiles(DateTime dateTime) {
    return '${dateTime.day}_${_month(dateTime.month)}_${dateTime.year}_${dateTime.hour}-${_addCero(dateTime.minute)}';
  }

  static String dateFiles(DateTime dateTime) {
    return '${dateTime.day}_${_month(dateTime.month)}_${dateTime.year}';
  }

  static String dateTimeWithoutCompare(DateTime tiempo) {
    return "${tiempo.day} " +
        _month(tiempo.month) +
        " ${tiempo.hour}:" +
        _addCero(tiempo.minute);
  }

  static String dateTimeCompare(DateTime tiempo) {
    DateTime hoy = DateTime.now();
    if (hoy.day == tiempo.day &&
        hoy.month == tiempo.month &&
        hoy.year == tiempo.year) {
      return "Hoy ${tiempo.hour}:" + _addCero(tiempo.minute);
    } else {
      if ((hoy.day - 1) == tiempo.day &&
          hoy.month == tiempo.month &&
          hoy.year == tiempo.year) {
        return "Ayer ${tiempo.hour}:" + _addCero(tiempo.minute);
      } else {
        return "${tiempo.day} " +
            _month(tiempo.month) +
            " ${tiempo.hour}:" +
            _addCero(tiempo.minute);
      }
    }
  }

  static String _month(int n) {
    switch (n) {
      case 1:
        return "Enero";
      case 2:
        return "Febrero";
      case 3:
        return "Marzo";
      case 4:
        return "Abril";
      case 5:
        return "Mayo";
      case 6:
        return "Junio";
      case 7:
        return "Julio";
      case 8:
        return "Agosto";
      case 9:
        return "Septiembre";
      case 10:
        return "Octubre";
      case 11:
        return "Noviembre";
      case 12:
        return "Diciembre";
      default:
        return "$n";
    }
  }

  static String _addCero(int n) {
    if (n < 10) {
      return "0$n";
    } else {
      return "$n";
    }
  }
}