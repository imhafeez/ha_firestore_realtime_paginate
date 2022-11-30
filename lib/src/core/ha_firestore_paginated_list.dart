// part of ha_firestore_realtime_paginate;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ha_firestore_realtime_paginate/src/core/realtime_pagination_model.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'ha_list_item_view.dart';

/// HAFirestoreRealtimePaginatedView
class HAFirestoreRealtimePaginatedView extends StatefulWidget {
  /// Firestore collection query
  final Query? query;

  /// Specify the page limit for each page
  final int? limit;

  /// Widget for each cell in the list
  final Widget Function(BuildContext context, DocumentSnapshot snapshot)?
      builder;

  /// Widget to show when there is no record from specified query
  final Widget? emptyWidget;

  /// Scroll padding for ListView
  final EdgeInsets scrollPadding;

  /// maxCrossAxisExtent for Grid View
  final double? maxCrossAxisExtent;
  // final int Function(DocumentSnapshot a, DocumentSnapshot b)? sort;

  /// Add a filter to the result
  final bool Function(DocumentSnapshot a)? filter;

  /// return a header widget in case of grouped view
  final Widget Function(dynamic)? header;

  /// Specify a document field to groupBy the records
  final String? groupBy;

  /// List style List or Grid
  final ListViewStyle style;

  // final ScrollPhysics? physics;

  // final bool? shrinkWrap;

  const HAFirestoreRealtimePaginatedView({
    Key? key,
    this.query,
    this.builder,
    this.limit = 10,
    this.emptyWidget,
    this.filter,
    this.scrollPadding = const EdgeInsets.all(0),
    this.maxCrossAxisExtent = 350,
    this.header,
    this.groupBy,
    this.style = ListViewStyle.list,
  }) : super(key: key);

  @override
  _HAFirestoreRealtimePaginatedViewState createState() =>
      _HAFirestoreRealtimePaginatedViewState();
}

class _HAFirestoreRealtimePaginatedViewState
    extends State<HAFirestoreRealtimePaginatedView> {
  late RealtimePaginatinModel model;

  @override
  void initState() {
    super.initState();

    model = RealtimePaginatinModel(query: widget.query, limit: widget.limit);
    model.requestNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DocumentSnapshot>>(
      stream: model.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if ((snapshot.data?.length ?? 0) > 0) {
          List<DocumentSnapshot>? listData = snapshot.data;

          if (widget.filter != null) {
            listData = listData?.where(widget.filter!).toList() ?? [];
          }

          return LazyLoadScrollView(
            onEndOfPage: () {
              model.requestNextPage();
            },
            child: HAListItemView(
              builder: widget.builder,
              data: listData,
              groupByField: widget.groupBy,
              header: widget.header,
              maxCrossAxisExtent: widget.maxCrossAxisExtent,
              scrollPadding: widget.scrollPadding,
              style: widget.style,
            ),
          );
        } else {
          return widget.emptyWidget ?? Container();
        }
      },
    );
  }

  // dynamic buildWaterfallFlow(List<dynamic>? listData, BuildContext context) {
  //   if ((widget.groupBy ?? "").isNotEmpty && widget.header != null) {
  //     Map<dynamic, List<dynamic>> dataMap;
  //     if (listData is List<DocumentSnapshot>) {
  //       dataMap = groupBy(listData, (snapshot) {
  //         if (snapshot.data()[widget.groupBy] is Timestamp) {
  //           DateTime? dateTime = utcToLocal(snapshot.data()[widget.groupBy]);
  //           return DateFormat('dd/MM/yyyy')
  //               .parse(DateFormat('dd/MM/yyyy').format(dateTime!));
  //         } else
  //           return snapshot.data()[widget.groupBy];
  //       });
  //     } else {
  //       dataMap = groupBy<dynamic, String?>(listData!, (e) {
  //         Map<String, dynamic> map = e.toJson();
  //         return map[widget.groupBy!];
  //       });
  //     }
  //     return ListView(
  //       children: dataMap.keys.map((e) {
  //         return StickyHeader(
  //           header: widget.header!(e),
  //           content: WaterfallFlow(
  //             shrinkWrap: true,
  //             physics: NeverScrollableScrollPhysics(),
  //             padding: widget.scrollPadding,
  //             gridDelegate: SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
  //                 maxCrossAxisExtent: widget.maxCrossAxisExtent!,
  //                 mainAxisSpacing: 8),
  //             children: dataMap[e]!.map((e) {
  //               return widget.builder!(context, e);
  //             }).toList(),
  //           ),
  //         );
  //       }).toList(),
  //     );
  //   } else {
  //     return WaterfallFlow(
  //       padding: widget.scrollPadding,
  //       gridDelegate: SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
  //           maxCrossAxisExtent: widget.maxCrossAxisExtent!, mainAxisSpacing: 8),
  //       children: listData!.map((e) => widget.builder!(context, e)).toList(),
  //     );
  //   }
  // }

  // ListView buildListView(List<dynamic>? listData, BuildContext context) {
  //   if ((widget.groupBy ?? "").isNotEmpty && widget.header != null) {
  //     Map<dynamic, List<dynamic>> dataMap;
  //     if (listData is List<DocumentSnapshot>) {
  //       dataMap = groupBy(listData, (snapshot) {
  //         if (snapshot.data()[widget.groupBy] is Timestamp) {
  //           DateTime? dateTime = utcToLocal(snapshot.data()[widget.groupBy]);
  //           return DateFormat('dd/MM/yyyy')
  //               .parse(DateFormat('dd/MM/yyyy').format(dateTime!));
  //         } else
  //           return snapshot.data()[widget.groupBy];
  //       });
  //     } else {
  //       dataMap = groupBy<dynamic, String?>(listData!, (e) {
  //         Map<String, dynamic> map = e.toJson();
  //         return map[widget.groupBy!];
  //       });
  //     }

  //     return ListView(
  //       children: dataMap.keys.map((e) {
  //         return StickyHeader(
  //           header: widget.header!(e),
  //           content: ListView(
  //             shrinkWrap: true,
  //             physics: NeverScrollableScrollPhysics(),
  //             children: dataMap[e]!.map((e) {
  //               return widget.builder!(context, e);
  //             }).toList(),
  //           ),
  //         );
  //       }).toList(),
  //     );
  //   } else {
  //     return ListView(
  //       padding: widget.scrollPadding,
  //       children: listData!.map((e) => widget.builder!(context, e)).toList(),
  //     );
  //   }
  // }
}
