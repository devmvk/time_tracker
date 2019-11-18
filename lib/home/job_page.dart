import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker/common/platform_alert_dialog.dart';
import 'package:time_tracker/common/platform_exception_alert_dialog.dart';
import 'package:time_tracker/models/job.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/services/database.dart';

class JobPage extends StatelessWidget {
  AuthBase auth;

  void _signOut() async {
    await auth.signOut();
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final _didRequestLogOut = await PlatformAlertDialog(
      content: "Are you sure you want to logout?",
      title: "Logout",
      defalutActionText: "Logout",
    ).show(context);

    if (_didRequestLogOut == true) {
      _signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthBase>(context);
    return SafeArea(
      child: Scaffold(
        body: _buildContents(context),
        appBar: AppBar(
          title: Text("Jobs"),
          actions: <Widget>[
            FlatButton(
                onPressed: () => _confirmLogout(context),
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _createJob(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _createJob(BuildContext context) async {
    DataBase _dataBase = Provider.of<DataBase>(context);
    try {
      await _dataBase
          .createJob(Job(name: "Coding", ratePerHour: 17, id: "job_abc"));
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        exception: e,
        title: "Operation Failed",
      ).show(context);
    }
  }

  _buildContents(BuildContext context) {
    DataBase _dataBase = Provider.of<DataBase>(context);
    return StreamBuilder(
      stream: _dataBase.jobStream(),
      builder: (BuildContext context, AsyncSnapshot<List<Job>> snapshot){
        if(snapshot.hasData){
          return ListView(
            children: snapshot.data.map((job) => Text(job.name)).toList(),
          );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}
