import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/services/auth_service.dart';
import 'package:flutterapp/services/database_service.dart';
import 'package:flutterapp/services/log_service.dart';
import 'package:flutterapp/trash/calendar_example2.dart';
import 'package:flutterapp/trash/call_to_action.dart';
import 'package:flutterapp/trash/course_details.dart';
import 'package:flutterapp/trash/my_own_widget.dart';
import 'package:flutterapp/trash/navigation_bar.dart';
import 'package:flutterapp/trash/centered_view.dart';
import 'package:provider/provider.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    // final userId = Provider.of<UserModel?>(context)!.uid;
    return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseService().posts, 
      initialData: null,
      child: Scaffold(
        appBar: AppBar(title: const Text("Home"), elevation: 0, actions: <Widget>[
          FilledButton(
            child: const Row(children: [
              Text("Log out"),
              Icon(Icons.person),
            ]),
            // Text('Logout'),
            onPressed: () async {
              await authService.signOut();
            },
          )
        ]),
        body: CenteredView(
          child: Column(
            children: [
              FilledButton(onPressed: () => log(this), child: const Text('DEBUG')),
              const MyNavigationBar(),
              const Row(
                children: [
                  CourseDetails(),
                  Center(
                    child: CallToAction(
                      title: 'hybbede',
                    ),
                  ),
                  CalendarExample2(),
                ],
              ),
              const MyOwnWidget(),
              // NewTestWidget()
            ],
          ),
        ),
      ),
    );
  }
}
