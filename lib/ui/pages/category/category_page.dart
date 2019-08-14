import 'package:flutter/material.dart';
import 'package:restorder/logic/bloc/category_bloc.dart';
import 'package:restorder/logic/viewmodel/restaurant_view_model.dart';
import 'package:restorder/models/category/category_response.dart';
import 'package:restorder/models/dashboard/dashboard_response.dart';
import 'package:restorder/models/fetch_process.dart';
import 'package:restorder/services/network/api_subscription.dart';
import 'package:restorder/ui/pages/categorydetail/category_details_page.dart';
import 'package:restorder/ui/widgets/common_scaffold.dart';
import 'package:restorder/utils/uidata.dart';

import 'category_items.dart';

class CategoryPage extends StatefulWidget {
  final DashBoardResponse dashBoardResponse;
  CategoryPage({Key key, @required this.dashBoardResponse}) : super(key: key);

  @override
  CategoryState createState() {
    return new CategoryState();
  }
}

class CategoryState extends State<CategoryPage> {
  final _scaffoldState = GlobalKey<ScaffoldState>();
  final CategoryBloc categoryBloc = CategoryBloc();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      actionFirstIcon: null,
      appTitle: widget.dashBoardResponse.title.toUpperCase(),
      showDrawer: false,
      scaffoldKey: _scaffoldState,
      bodyData: bodyData(),
    );
  }

  @override
  void initState() {
    super.initState();

    apiSubscription(categoryBloc.categoryListResult, this.context);
    categoryBloc.categoryListSink.add(RestaurantViewModel.dashboard(dashboardId: widget.dashBoardResponse.id));
    apiSubscription(categoryBloc.categoryListResult, this.context);
  }

  bodyData() {
    return ListView(physics: BouncingScrollPhysics(), children: <Widget>[
      Column(
        children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                StreamBuilder<FetchProcess>(
                    stream: categoryBloc.categoryListResult,
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? snapshot.data.statusCode == UIData.resCode200
                              ? _bodyList(
                                  snapshot.data.networkServiceResponse.response)
                              : Container()
                          : CircularProgressIndicator();
                    })
              ])
        ],
      )
    ]);
  }

  _bodyList(List<CategoryResponse> dashBoardResponseList) {
    return new ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: dashBoardResponseList.map((value) {
        return GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new CategoryDetailsPage(categoryResponse: value))),
            child: CategoryItems(
              categoryResponse: value,
            ));
      }).toList(),
    );
  }
}
