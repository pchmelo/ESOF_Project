import '../models/validity.model.dart';

class ProductFilter {
  List<Map<String, dynamic>> emptyFilter(
      List<Map<String, dynamic>> allProducts) {
    return allProducts;
  }

  List<Map<String, dynamic>> sortAlphabeticallyAsc(
      List<Map<String, dynamic>> allProducts) {
    allProducts.sort((a, b) {
      int compare = a['name'].compareTo(b['name']);
      if (compare != 0) {
        return compare;
      } else {
        return a['quantity'].compareTo(b['quantity']);
      }
    });
    return allProducts;
  }

  List<Map<String, dynamic>> sortAlphabeticallyDesc(
      List<Map<String, dynamic>> allProducts) {
    allProducts.sort((a, b) {
      int compare = b['name'].compareTo(a['name']);
      if (compare != 0) {
        return compare;
      } else {
        return b['quantity'].compareTo(a['quantity']);
      }
    });
    return allProducts;
  }

  List<Map<String, dynamic>> sortByQuantityDesc(
      List<Map<String, dynamic>> allProducts) {
    allProducts.sort((a, b) {
      int compare = b['quantity'].compareTo(a['quantity']);
      if (compare != 0) {
        return compare;
      } else {
        return b['name'].compareTo(a['name']);
      }
    });
    return allProducts;
  }

  List<Map<String, dynamic>> sortByQuantityAsc(
      List<Map<String, dynamic>> allProducts) {
    allProducts.sort((a, b) {
      int compare = a['quantity'].compareTo(b['quantity']);
      if (compare != 0) {
        return compare;
      } else {
        return a['name'].compareTo(b['name']);
      }
    });
    return allProducts;
  }
}

class ValidityFilter {
  List<Map<String, dynamic>> emptyFilter(
      List<Map<String, dynamic>> allValidities) {
    return allValidities;
  }

  List<Map<String, dynamic>> sortAlphabeticallyAsc(
      List<Map<String, dynamic>> allValidities) {
    allValidities.sort((a, b) {
      int compare = a['name'].compareTo(b['name']);
      if (compare != 0) {
        return compare;
      } else {
        return a['quantity'].compareTo(b['quantity']);
      }
    });
    return allValidities;
  }

  List<Map<String, dynamic>> sortAlphabeticallyDesc(
      List<Map<String, dynamic>> allValidities) {
    allValidities.sort((a, b) {
      int compare = b['name'].compareTo(a['name']);
      if (compare != 0) {
        return compare;
      } else {
        return b['quantity'].compareTo(a['quantity']);
      }
    });
    return allValidities;
  }

  List<Map<String, dynamic>> sortByQuantityDesc(
      List<Map<String, dynamic>> allValidities) {
    allValidities.sort((a, b) {
      int compare = b['quantity'].compareTo(a['quantity']);
      if (compare != 0) {
        return compare;
      } else {
        return b['name'].compareTo(a['name']);
      }
    });
    return allValidities;
  }

  List<Map<String, dynamic>> sortByQuantityAsc(
      List<Map<String, dynamic>> allValidities) {
    allValidities.sort((a, b) {
      int compare = a['quantity'].compareTo(b['quantity']);
      if (compare != 0) {
        return compare;
      } else {
        return a['name'].compareTo(b['name']);
      }
    });
    return allValidities;
  }

  List<Map<String, dynamic>> sortByValidityDateAsc(
      List<Map<String, dynamic>> allValidities) {
    allValidities.sort((a, b) {
      DateTime dateA = DateTime(a['year'], a['month'], a['day']);
      DateTime dateB = DateTime(b['year'], b['month'], b['day']);
      return dateA.compareTo(dateB);
    });
    return allValidities;
  }

  List<Map<String, dynamic>> sortByValidityDateDesc(
      List<Map<String, dynamic>> allValidities) {
    allValidities.sort((a, b) {
      DateTime dateA = DateTime(a['year'], a['month'], a['day']);
      DateTime dateB = DateTime(b['year'], b['month'], b['day']);
      return dateB.compareTo(dateA);
    });
    return allValidities;
  }

  List<Validity> sortValiditiesByDateAsc(List<Validity> allValidities) {
    allValidities.sort((a, b) {
      DateTime dateA = DateTime(a.year, a.month, a.day);
      DateTime dateB = DateTime(b.year, b.month, b.day);
      return dateA.compareTo(dateB);
    });
    return allValidities;
  }
}
