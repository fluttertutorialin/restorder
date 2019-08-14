import 'package:flutter/material.dart';
import 'package:restorder/logic/bloc/dashboard_bloc.dart';
import 'package:restorder/logic/bloc/shopping_bloc.dart';
import 'package:restorder/logic/blocprovider/bloc_provider.dart';
import 'package:restorder/ui/widgets/common_drawer.dart';
import 'package:restorder/ui/widgets/custom_float.dart';
import 'package:restorder/utils/uidata.dart';

import 'badge_icon.dart';
import 'basket_icon.dart';

class CommonScaffold extends StatelessWidget {
  final appTitle;
  final Widget bodyData;
  final showFAB;
  final showDrawer;
  final actionFirstIcon;
  final scaffoldKey;
  final showBottomNav;
  final centerDocked;
  final elevation;
  final Widget bottomBar;
  final showOrderItems;
  final showSorting;

  CommonScaffold(
      {this.appTitle,
      this.bodyData,
      this.showFAB = false,
      this.showDrawer = false,
      this.actionFirstIcon = Icons.search,
      this.scaffoldKey,
      this.showBottomNav = false,
      this.centerDocked = false,
      this.elevation = 0.3,
      this.bottomBar,
      this.showOrderItems = true,
      this.showSorting = false});

  @override
  Widget build(BuildContext context) {
    DashboardBloc dashboardBloc = BlocProvider.of<DashboardBloc>(context);

    return Scaffold(
      key: scaffoldKey != null ? scaffoldKey : null,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
              padding: EdgeInsets.only(left: 1, right: 1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 16,
                    color: Colors.black.withOpacity(.0),
                    offset: Offset(0, 16),
                  )
                ],
              ),
              child: Container(
                  child: Row(children: <Widget>[
                expandStyle(
                    0,
                    Container(
                      width: 90,
                      height: 80,
                      padding: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: UIData.drawerArrowGradients,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(100)),
                      ),
                      child: IconButton(
                          icon: showDrawer
                              ? Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                          onPressed: () => showDrawer
                              ? scaffoldKey.currentState.openDrawer()
                              : Navigator.of(context).pop()),
                    )),
                expandStyle(
                    1,
                    Text(appTitle,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: UIData.colorAppTitle))),
                showOrderItems
                    ? new BasketIcon(
                        () => Navigator.pushNamed(context, UIData.orderRoute))

                    /*InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, UIData.orderRoute),
                            child: Stack(
                                overflow: Overflow.visible,
                                children: <Widget>[
                                  Align(
                                    child: const Icon(Icons.shopping_cart,
                                        color: Colors.black45),
                                  ),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Transform.translate(
                                          offset: Offset(-5.0, 18.0),
                                          child: StreamBuilder<int>(
                                              stream: bloc.shoppingBasketSize,
                                              initialData: 0,
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<int> snapshot) {
                                                return Container(
                                                    width: 20.0,
                                                    height: 20.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                            '0${snapshot.data}',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10.0,
                                                            ))));
                                              })))
                                ]))*/
                    : Container(),
                showSorting
                    ? new StreamBuilder(
                        stream: dashboardBloc.sortingName,
                        builder: (context, snapshot) {
                          return new InkWell(
                              onTap: () {
                                snapshot.data == 'asc'
                                    ? dashboardBloc.listSorting('des')
                                    : dashboardBloc.listSorting('asc');
                              },
                              child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.sort,
                                      color: Colors.black54, size: 20)));
                        })
                    : Container()
              ])))),
      drawer: showDrawer ? CommonDrawer() : null,
      body: bodyData,
      floatingActionButton: showFAB
          ? CustomFloat(
              builder: centerDocked
                  ? Text(
                      "",
                      style: TextStyle(color: Colors.black87, fontSize: 10.0),
                    )
                  : null,
              icon: Icons.add_shopping_cart,
              isMini: true,
              qrCallback: () {},
            )
          : null,
      floatingActionButtonLocation: centerDocked
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: showBottomNav ? bottomBar : null,
    );
  }

  expandStyle(int flex, Widget child) => Expanded(flex: flex, child: child);
}
