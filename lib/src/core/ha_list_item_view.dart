import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ha_firestore_realtime_paginate/src/layout/screen_type_layout.dart';
import 'package:ha_firestore_realtime_paginate/src/utils/converters.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

enum ListViewStyle { list, grid, auto }

class HAListItemView extends StatelessWidget {
  final ListViewStyle style;
  final EdgeInsets? scrollPadding;
  final List<dynamic>? data;
  final Widget Function(dynamic)? header;
  final String? groupByField;
  final Widget Function(BuildContext context, DocumentSnapshot snapshot)?
      builder;

  final double? maxCrossAxisExtent;
  const HAListItemView({
    Key? key,
    this.style = ListViewStyle.list,
    this.scrollPadding,
    this.data,
    this.groupByField,
    this.header,
    this.builder,
    this.maxCrossAxisExtent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return style == ListViewStyle.list
        ? buildListView(data, context)
        : (style == ListViewStyle.grid)
            ? buildWaterfallFlow(data, context)
            : ScreenTypeLayout(
                mobile: buildListView(data, context),
                tablet: buildWaterfallFlow(data, context),
                desktop: buildWaterfallFlow(data, context),
              );
  }

  dynamic buildWaterfallFlow(List<dynamic>? listData, BuildContext context) {
    if ((groupByField ?? "").isNotEmpty && header != null) {
      Map<dynamic, List<dynamic>> dataMap;
      if (listData is List<DocumentSnapshot>) {
        dataMap = groupBy(listData, (snapshot) {
          if (snapshot.data()[groupByField] is Timestamp) {
            DateTime? dateTime = utcToLocal(snapshot.data()[groupByField]);
            return DateFormat('dd/MM/yyyy')
                .parse(DateFormat('dd/MM/yyyy').format(dateTime!));
          } else {
            return snapshot.data()[groupByField];
          }
        });
      } else {
        dataMap = groupBy<dynamic, String?>(listData!, (e) {
          Map<String, dynamic> map = e.toJson();
          return map[groupByField!];
        });
      }
      return ListView(
        children: dataMap.keys.map((e) {
          return StickyHeader(
            header: header!(e),
            content: WaterfallFlow(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: scrollPadding,
              gridDelegate: SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: maxCrossAxisExtent!, mainAxisSpacing: 8),
              children: dataMap[e]!.map((e) {
                return builder!(context, e);
              }).toList(),
            ),
          );
        }).toList(),
      );
    } else {
      return WaterfallFlow(
        padding: scrollPadding,
        gridDelegate: SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: maxCrossAxisExtent!, mainAxisSpacing: 8),
        children: listData!.map((e) => builder!(context, e)).toList(),
      );
    }
  }

  ListView buildListView(List<dynamic>? listData, BuildContext context) {
    if ((groupByField ?? "").isNotEmpty && header != null) {
      Map<dynamic, List<dynamic>> dataMap;
      if (listData is List<DocumentSnapshot>) {
        dataMap = groupBy(listData, (snapshot) {
          if (snapshot.data()[groupByField] is Timestamp) {
            DateTime? dateTime = utcToLocal(snapshot.data()[groupByField]);
            return DateFormat('dd/MM/yyyy')
                .parse(DateFormat('dd/MM/yyyy').format(dateTime!));
          } else {
            return snapshot.data()[groupByField];
          }
        });
      } else {
        dataMap = groupBy<dynamic, String?>(listData!, (e) {
          Map<String, dynamic> map = e.toJson();
          return map[groupByField!];
        });
      }

      return ListView(
        children: dataMap.keys.map((e) {
          return StickyHeader(
            header: header!(e),
            content: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: dataMap[e]!.map((e) {
                return builder!(context, e);
              }).toList(),
            ),
          );
        }).toList(),
      );
    } else {
      return ListView(
        padding: scrollPadding,
        children: listData!.map((e) => builder!(context, e)).toList(),
      );
    }
  }
}
