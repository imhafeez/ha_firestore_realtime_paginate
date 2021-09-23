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
# Firestore Realtime Paginationed list or grid view 
Flutter library for displaying realtime paginated list view or gird view based on screensize.

[![](http://flutter-badge.zaynjarvis.com/version/{ha_firestore_realtime_paginate})](https://pub.dartlang.org/packages/{ha_firestore_realtime_paginate})
[![](http://flutter-badge.zaynjarvis.com/score/{ha_firestore_realtime_paginate})](https://pub.dartlang.org/packages/{ha_firestore_realtime_paginate})

## Features


- Firestore Realtime pagination
- List view style
- Grouped List View
- Waterflow Grid view style


---
## Getting started

Add dependency
```
dependencies:
  ha_firestore_realtime_paginate: # latest version

```

## Usage


```dart
    HAFirestoreRealtimePaginatedView(
      style: ListViewStyle.AutoStyle,
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
### Grouping (Sticky Headers)

You can group your listing by passing ``` groupBy ``` field and your ``` header ``` widget in the ``` HAFirestoreRealtimePaginatedView ``` constructor.

```dart
HAFirestoreRealtimePaginatedView(
  ...
  groupBy: "addedDate",
  header: (groupFieldValue) {
    return Container(
      color: Colors.white,
      child: Text("$groupFieldValue"),
    );
  },
  ...
)
```
### Filter

You can apply filter for not to include a document in the listing

```dart
bool Function(DocumentSnapshot a)? filter
```
# Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an issue. If you fixed a bug or implemented a feature, please send a pull request.


