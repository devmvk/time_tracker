import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker/common/list_item_builder.dart';
import 'package:time_tracker/common/platform_alert_dialog.dart';
import 'package:time_tracker/common/platform_exception_alert_dialog.dart';
import 'package:time_tracker/home/add_job_page.dart';
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
          onPressed: () => AddJobPage.show(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  _buildContents(BuildContext context) {
    DataBase _dataBase = Provider.of<DataBase>(context);
    return StreamBuilder(
      stream: _dataBase.jobStream(),
      builder: (BuildContext context, AsyncSnapshot<List<Job>> snapshot) {
        return ListItemBuilder<Job>(
          snapshot: snapshot,
          widgetBuilder: (BuildContext context, Job job) => Dismissible(
            key: Key("job-${job.id}"),
            background: Container(
              color: Colors.red,
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _deleteJob(context, job),
            child: ListTile(
              title: Text(job.name),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                AddJobPage.show(
                  context,
                  job: job,
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteJob(BuildContext context, Job job) async{
    final database = Provider.of<DataBase>(context);
    try{
      await database.deleteJob(job);
    }on PlatformException catch(e){
      PlatformExceptionAlertDialog(
        exception: e,
        title: "Error",
      ).show(context);
    }
  }
}
