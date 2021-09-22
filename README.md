<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->
# Realtime Pagination list/grid view for Firestore
Flutter library for displaying realtime paginated list view or gird view based on screensize.
## Features


- Firestore Realtime pagination
- List view style
- Waterflow Grid view style


---
## Getting started

Add dependency
```
dependencies:
  ha_firestore_paginated_list: # latest version

```

## Usage

For List View

```dart
    HAFirestoreRealtimePaginatedView.list(
      scrollPadding: EdgeInsets.only(bottom: 90),
      query: FirebaseFirestore.instance.collection("users")
          .where("isDeleted", isEqualTo: false)
          .orderBy("addedDate", descending: true),
      limit: 10,
      builder: (context, snapshot) {
         Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return ListTile(
          title: Text(data['name'] ?? "no name"),
        );
      },
      emptyWidget: Center(
        child: Text("no data found"),
      ),
    )
```

For Grid View 

```dart
    HAFirestoreRealtimePaginatedView.grid(
      maxCrossAxisExtent: 380,
      scrollPadding: EdgeInsets.only(bottom: 90),
      query: FirebaseFirestore.instance
          .collection("users")
          .where("isDeleted", isEqualTo: false)
          .orderBy("addedDate", descending: true),
      limit: 10,
      builder: (context, snapshot) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return ListTile(
          title: Text(data['name'] ?? "no name"),
        );
      },
      emptyWidget: Center(
        child: Text("no data found"),
      ),
    );
```
# Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an issue. If you fixed a bug or implemented a feature, please send a pull request.


