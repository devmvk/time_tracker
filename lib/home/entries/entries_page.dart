import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/home/entries/entries_bloc.dart';
import 'package:time_tracker/home/entries/entries_list_tile.dart';
import 'package:time_tracker/common/list_item_builder.dart';
import 'package:time_tracker/services/database.dart';

class EntriesPage extends StatelessWidget {
  static Widget create(BuildContext context) {
    final database = Provider.of<DataBase>(context);
    return Provider<EntriesBloc>(
      builder: (_) => EntriesBloc(database: database),
      child: EntriesPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entries'),
        elevation: 2.0,
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final bloc = Provider.of<EntriesBloc>(context);
    return StreamBuilder<List<EntriesListTileModel>>(
      stream: bloc.entriesTileModelStream,
      builder: (context, snapshot) {
        return ListItemBuilder<EntriesListTileModel>(
          snapshot: snapshot,
          widgetBuilder: (context, model) => EntriesListTile(model: model),
        );
      },
    );
  }
}
