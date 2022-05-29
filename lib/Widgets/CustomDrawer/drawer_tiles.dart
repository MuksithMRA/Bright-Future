import 'package:brightfuture/Providers/drawer_tile_change.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'drawer_tile_widget.dart';

class DrawerTiles extends StatelessWidget {
  const DrawerTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tileData = Provider.of<DrawerTileChange>(context, listen: true);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: tileData.drawerTileData.length,
      itemBuilder: (BuildContext context, int index) {
        return DrawerTile(
          index: index,
        );
      },
    );
  }
}
