import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/common/platform_exception_alert_dialog.dart';
import 'package:time_tracker/models/job.dart';
import 'package:time_tracker/services/database.dart';

class AddJobPage extends StatefulWidget {

  final DataBase dataBase;

  const AddJobPage({Key key, this.dataBase}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    final database = Provider.of<DataBase>(context);
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => AddJobPage(dataBase: database,),
    ));
  }

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  int _ratePerHour;
  String _jobName;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Job"),
        elevation: 2.0,
        actions: <Widget>[
          FlatButton(
            onPressed: _submit,
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: _buildContents(),
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: "Job Name"),
            onSaved: (String value) => _jobName = value,
            validator: (String value) => value.isNotEmpty ? null : "required",
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Rate per hour"),
            keyboardType: TextInputType.numberWithOptions(),
            onSaved: (String value) => _ratePerHour = int.tryParse(value) ?? 0,
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (_validateAndSave()) {
      try{
        widget.dataBase.createJob(Job(name: _jobName, ratePerHour: _ratePerHour, id: DateTime.now().toIso8601String()));
      }on PlatformException catch (e){
        PlatformExceptionAlertDialog(
          exception: e,
          title: "Operation Failed",
        ).show(context);
      }
    }
  }

  bool _validateAndSave() {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      return true;
    }
    return false;
  }
}
