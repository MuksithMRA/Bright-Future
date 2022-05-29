import 'package:brightfuture/Models/drawer_tile.dart';
import 'package:brightfuture/Providers/drawer_tile_change.dart';
import 'package:brightfuture/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {

  final int index;
  const DrawerTile({Key? key,  required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Consumer<DrawerTileChange>(
      builder: (context, items, child) {
        DrawerTileModel item = items.drawerTileData[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            selected: item.isTapped,
            selectedTileColor: primaryColor.withOpacity(0.3),
            onTap: () {
              items.onTileTapped(index: index, context: context);
            },
            leading:
                FaIcon(item.icon, color: item.isTapped ? primaryColor : kBlack),
            title: Text(
              item.title,
              style: TextStyle(
                color: item.isTapped ? primaryColor : kBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}



//  color: item.isTapped ? primaryColor : kBlack,
//           text: item.title,
//           fontWeight: FontWeight.bold,