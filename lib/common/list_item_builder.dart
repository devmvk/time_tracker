import 'package:flutter/material.dart';
import 'package:time_tracker/common/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemBuilder<T> extends StatelessWidget {
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> widgetBuilder;

  const ListItemBuilder({Key key, this.snapshot, this.widgetBuilder}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    if(snapshot.hasData){
      final List<T> _items = snapshot.data;
      if(_items.isNotEmpty){
        return _buildWiget(context, _items);
      }
      return EmptyContent();
    }else if(snapshot.hasError){
      return EmptyContent(title: "Something went wrong", content: "Try again",);
    }
    return CircularProgressIndicator();
  }

  Widget _buildWiget(BuildContext context, List<T> items){
    return Container(
      child: ListView(
        children: items.map((T item) => widgetBuilder(context, item)).toList(),
      ),
    );
  }
}