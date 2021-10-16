import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mplacementtracker/UI/Admin/admin_dashboard.dart';
import 'package:mplacementtracker/UI/Student/student_profile.dart';
import 'package:mplacementtracker/UI/widgets/header_widget.dart';
import 'package:mplacementtracker/model/user.dart';
import 'package:mplacementtracker/services/helper.dart';

import '../../main.dart';
import '../login_page.dart';

class StudentDashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentDashboardState();
  }
}

class _StudentDashboardState extends State<StudentDashboard> {
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ])),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(
              top: 16,
              right: 16,
            ),
            child: Stack(
              children: <Widget>[
                Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                0.0,
                1.0
              ],
                  colors: [
                Theme.of(context).primaryColor.withOpacity(0.2),
                Theme.of(context).accentColor.withOpacity(0.5),
              ])),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                    ],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Student",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.password_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).accentColor),
                ),
                //  onPressed: () => login(),
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: _buildListView(
        child: Stack(
          children: [
            Container(
              height: 100,
              child: HeaderWidget(100, false, Icons.house_rounded),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  ListView _buildListView({Stack? child}) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, index) {
        return Card(
          child: ListTile(
            title: Text('$index. Company'),
            subtitle: Text('the sub'),
            leading: Icon(Icons.thumb_up),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed:(){
                Navigator.push( context, MaterialPageRoute(builder: (context) => AdminDashboard(),
                )
                );
              }
          ),
        ),
        );
      },
    );
  }
}
