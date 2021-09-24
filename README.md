<!-- 
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-2-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

<p align="center">
	<a href="https://pub.dev/packages/ha_firestore_realtime_paginate"><img src="https://img.shields.io/pub/v/ha_firestore_realtime_paginate.svg" alt="Pub.dev Badge"></a>
	<!-- <a href="https://github.com/imhafeez/ha_firestore_sacffold/actions"><img src="https://github.com/imhafeez/ha_firestore_sacffold/workflows/build/badge.svg" alt="GitHub Build Badge"></a> -->
	<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="MIT License Badge"></a>
	<a href="https://github.com/imhafeez/ha_firestore_sacffold"><img src="https://img.shields.io/badge/platform-flutter-ff69b4.svg" alt="Flutter Platform Badge"></a>
</p>

# Firestore Realtime Pagination view 
Flutter library for displaying realtime paginated list view or gird view based on screensize.

## Features
- Firestore Realtime pagination
- List view style
- Grouped List View
- Waterflow Grid view style



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


---

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/imhafeez"><img src="https://avatars.githubusercontent.com/u/21155655?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Hafeez Ahmed</b></sub></a><br /><a href="https://github.com/imhafeez/ha_firestore_realtime_paginate/commits?author=imhafeez" title="Code">💻</a></td>
   <td align="center"><a href="https://www.linkedin.com/in/hilalbaig/"><img src="https://avatars.githubusercontent.com/u/4985879?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Baig</b></sub></a><br /><a href="https://github.com/imhafeez/ha_firestore_realtime_paginate/commits?author=hilalbaig" title="Documentation">📖</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an issue. If you fixed a bug or implemented a feature, please send a pull request.
