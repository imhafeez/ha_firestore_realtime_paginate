import 'package:cloud_firestore/cloud_firestore.dart';

///Utc & Local Convertors
DateTime? localToUtc(DateTime? date) => date?.toUtc();
DateTime? utcToLocal(dynamic val) {
  if (val is DateTime) {
    return val;
  } else {
    Timestamp? timestamp;
    if (val is Timestamp) {
      timestamp = val;
    } else if (val is Map) {
      timestamp = Timestamp(val['_seconds'], val['_nanoseconds']);
    } else if (val is String) {
      DateTime date = DateTime.parse(val);
      return date.toLocal();
    }
    return (timestamp != null) ? timestamp.toDate().toLocal() : null;
  }
}
