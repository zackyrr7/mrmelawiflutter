enum Level {
  akun,
  kelompok,
  jenis,
  objek,
  rincianObjek,
  subRincianObjek;

  bool operator >(other) {
    return index > other.index;
  }

  bool operator <(other) {
    return index > other.index;
  }

  @override
  String toString() {
    switch (this) {
      case Level.akun:
        return "Akun";
      case Level.kelompok:
        return "Kelompok";
      case Level.jenis:
        return "Jenis";
      case Level.objek:
        return "Objek";
      case Level.rincianObjek:
        return "Rincian Objek";
      case Level.subRincianObjek:
        return "Sub Rincian Objek";
      default:
        return "";
    }
  }
}

class FinancialStatement {
  String accountCode;
  String accountName;
  double budgetOrTarget;
  double realization;
  Level level;

  FinancialStatement({
    required this.accountCode,
    required this.accountName,
    required this.budgetOrTarget,
    required this.realization,
    required this.level,
  });

  @override
  String toString() {
    return <String, dynamic>{
      "accountCode": accountCode,
      "accountName": accountName,
      "budgetOrTarget": budgetOrTarget,
      "realization": realization,
      "level": level,
    }.toString();
  }
}
