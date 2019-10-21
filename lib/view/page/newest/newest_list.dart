import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vincent_flutter/view/style/VCommonStyles.dart';
import 'package:vincent_flutter/view/utils/VCommonUtils.dart';

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(4, 1),
];

List<Widget> _tiles = const <Widget>[
  const _NewestListTile(Colors.green, Icons.widgets, "Tel"),
  const _NewestListTile(Colors.lightBlue, Icons.wifi, "WIFI"),
  const _NewestListTile(Colors.amber, Icons.panorama_wide_angle, "Img"),
  const _NewestListTile(Colors.brown, Icons.map, "Sms"),
  const _NewestListTile(Colors.deepOrange, Icons.send, "Sen"),
  const _NewestListTile(Colors.indigo, Icons.airline_seat_flat, "Airline"),
  const _NewestListTile(Colors.red, Icons.bluetooth, "Bluetooth"),
  const _NewestListTile(Colors.pink, Icons.battery_alert, "Battery Alert"),
  const _NewestListTile(Colors.purple, Icons.desktop_windows, "Win"),
  const _NewestListTile(Colors.blue, Icons.radio, "Radio"),
];

class NewestList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: new StaggeredGridView.count(
              crossAxisCount: 4,
              staggeredTiles: _staggeredTiles,
              children: _tiles,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              padding: const EdgeInsets.all(4.0),
            )));
  }
}

class _NewestListTile extends StatelessWidget {
  const _NewestListTile(this.backgroundColor, this.iconData, this.title);

  final Color backgroundColor;
  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: InkWell(
        onTap: () {
          if(title=="Tel"){
            VCommonUtils.callTel("18662673622");
          }else if(title=="Sms"){
            VCommonUtils.callSMS("18662673622");
          }else if(title=="Img"){
            VCommonUtils.pickImage(context);
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  iconData,
                  color: Colors.white,
                ),
                Text(title, style:VCommonStyles.largeTextWhite)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
