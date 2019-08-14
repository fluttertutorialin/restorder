import 'package:flutter/material.dart';
import 'package:restorder/logic/bloc/shopping_bloc.dart';
import 'package:restorder/logic/blocprovider/bloc_provider.dart';
import 'package:restorder/utils/uidata.dart';

class CommonDrawer extends StatefulWidget {
  @override
  _CommonDrawerState createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  List<Map<String, dynamic>> drawerMenuList = new List<Map<String, dynamic>>();
  ShoppingBloc shoppingBloc;

  @override
  Widget build(BuildContext context) {
    shoppingBloc = BlocProvider.of<ShoppingBloc>(context);
    this.drawerMenuList = this.drawerMenu();

    return Drawer(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            this._buildUserAccountProfileHeader(),
            this._buildDrawerBody()
          ]),
    );
  }

  _buildUserAccountProfileHeader() => Expanded(
        flex: 1,
        child: ClipPath(
          clipper: DashboardCustomClipper(),
          child: Container(
            color: Colors.orange,
            padding: EdgeInsets.only(top: 35.0, left: 20.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: CircleAvatar(
                    radius: 35.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(UIData.imageProfile),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Flutter',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text('https://fluttertutorial.in',
                      style:
                          new TextStyle(fontSize: 14.0, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      );

  Expanded _buildDrawerBody() => Expanded(
      flex: 2,
      child: ListView.builder(
          padding: EdgeInsets.only(top: 1.0),
          physics: BouncingScrollPhysics(),
          itemCount: this.drawerMenuList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.of(context).pop();
                    break;

                  case 1:
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, UIData.orderRoute);
                    break;

                  case 2:
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, UIData.favouriteRoute);
                    break;

                  case 3:
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, UIData.orderHistoryRoute);
                    break;

                  case 4:
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, UIData.profileRoute);
                    break;

                  case 5:
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, UIData.contactRoute);
                    break;

                  case 6:
                    Navigator.of(context).pop();
                   /* Navigator.of(context).pushNamedAndRemoveUntil(
                        UIData.loginRoute, (Route<dynamic> route) => false);*/
                    break;
                }
              },
              child: ListTile(
                  leading: Icon(this.drawerMenuList[index]['icon'],
                      color: Color(0xFFFFB74D)),
                  title: Text(this.drawerMenuList[index]['title'],
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0,
                          color: Colors.black87)),
                  trailing: index == 2
                      ? StreamBuilder(
                          stream: shoppingBloc.favoriteItemsSize,
                          initialData: 0,
                          builder: (BuildContext context,
                              AsyncSnapshot<int> snapshot) {
                            return Text('${snapshot.data}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.0,
                                    color: Colors.orange));
                          },
                        )
                      : Text('')),
            );
          }));

  List<Map<String, dynamic>> drawerMenu() {
    List<Map<String, dynamic>> menus = [
      {'title': 'Home', 'icon': Icons.home},
      {'title': 'My Order', 'icon': Icons.add_shopping_cart},
      {'title': 'Favourite', 'icon': Icons.favorite},
      {'title': 'Order Histroy', 'icon': Icons.history},
      {'title': 'Profile', 'icon': Icons.person_outline},
      {'title': 'Contact Us', 'icon': Icons.contacts},
      {'title': 'Logout', 'icon': Icons.vpn_key},
    ];
    return menus;
  }
}

class DashboardCustomClipper extends CustomClipper<Path> {
  final Path path = new Path();

  @override
  Path getClip(Size size) {
    this.path.lineTo(0.0, size.height - 50);
    this.path.lineTo(size.width, size.height);
    this.path.lineTo(size.width, 0.0);
    this.path.close();

    return this.path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
