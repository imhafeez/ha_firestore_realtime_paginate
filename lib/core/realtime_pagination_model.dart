import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class RealtimePaginatinModel {
  Query? query;
  final int? limit;
  RealtimePaginatinModel({required this.query, this.limit: 10});

  StreamController<List<DocumentSnapshot>> _streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();
  DocumentSnapshot? lastDocument;
  List<List<DocumentSnapshot>> documentPages = [];
  bool isRequesting = false;
  Stream<List<DocumentSnapshot>> get stream {
    return _streamController.stream;
  }

  Query? buildQuery() {
    query = query!.limit(limit!);

    if (lastDocument != null) {
      query = query!.startAfterDocument(lastDocument!);
    }
    ;
    return query;
  }

  void requestNextPage() {
    if (!isRequesting) {
      isRequesting = true;

      var currentRequestIndex = documentPages.length;

      buildQuery()!.snapshots().listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          var pageExists = currentRequestIndex < documentPages.length;

          if (pageExists) {
            documentPages[currentRequestIndex] = snapshot.docs;
          } else {
            documentPages.add(snapshot.docs);
          }

          var allPosts = documentPages.fold<List<DocumentSnapshot>>(
              <DocumentSnapshot>[],
              (initialValue, pageItems) => initialValue..addAll(pageItems));

          // #12: Broadcase all posts
          _streamController.add(allPosts);

          if (currentRequestIndex == documentPages.length - 1) {
            lastDocument = snapshot.docs.last;
          }

          isRequesting = false;
        } else {
          if (snapshot.docChanges.length > 0) {
            _streamController.add([]);
          }
        }
      });
      // subscribtionList.add(subscription);
    }
  }
}
