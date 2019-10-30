import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/common/platform_widget.dart';

class PlatformAlertDialog extends PlatformWidget{
   final String title;
   final String content;
   final String defalutActionText;
   final String cancelActionText;

  PlatformAlertDialog({
   @required this.title, @required this.content, @required this.defalutActionText, this.cancelActionText
  });

  Future<bool> show(BuildContext context) async{
    return Platform.isAndroid
      ? await showDialog<bool>(
          context: context,
          builder: (context) => this
        )
      : await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => this
        );
  }

  @override 
  Widget buildCupertinoWidget(BuildContext context){
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context)
    );
  }

  @override 
  Widget buildMaterialWidget(BuildContext context){
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context)
    );
  }

  List<Widget> _buildActions(BuildContext context){
    List<Widget> _actions = [];
    if(cancelActionText != null){
      _actions.add(
        PlatformAlertDialogAction(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelActionText),
        )
      );
    }
    _actions.add(
        PlatformAlertDialogAction(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(defalutActionText),
        )
      );

    return _actions;
  }

}

class PlatformAlertDialogAction extends PlatformWidget{
  final Widget child;
  final VoidCallback onPressed;

  PlatformAlertDialogAction({@required this.child, this.onPressed});


  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(
      child: child,
      onPressed: onPressed,
    );
  }
}