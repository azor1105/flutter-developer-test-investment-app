// ignore_for_file: constant_identifier_names

enum Countries {
  KZ,
  US,
  CN,
}

extension CountriesExtension on Countries {
  String get code {
    switch (this) {
      case Countries.KZ:
        return 'kz';
      case Countries.US:
        return 'us';
      case Countries.CN:
        return 'cn';
    }
  }

  String get name {
    switch (this) {
      case Countries.KZ:
        return 'Kazakhstan';
      case Countries.US:
        return 'United States';
      case Countries.CN:
        return 'China';
    }
  }

  String get flagAsset {
    switch (this) {
      case Countries.KZ:
        return 'assets/images/countries/KZ.png';
      case Countries.US:
        return 'assets/images/countries/US.png';
      case Countries.CN:
        return 'assets/images/countries/CN.png';
    }
  }
}