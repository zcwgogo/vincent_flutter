import 'package:flutter/material.dart';
import 'package:vincent_flutter/src/model/EventViewModel.dart';
import 'package:vincent_flutter/view/style/VCommonStyles.dart';
import 'package:vincent_flutter/view/widget/vw_card_item.dart';
import 'package:vincent_flutter/view/widget/vw_icon_widget.dart';

class VWEventItem extends StatelessWidget {
  final EventViewModel eventViewModel;

  final VoidCallback onPressed;

  final bool needImage;

  VWEventItem(this.eventViewModel, {this.onPressed, this.needImage = true}) : super();

  @override
  Widget build(BuildContext context) {
    Widget des = (eventViewModel.actionDes == null || eventViewModel.actionDes.length == 0)
        ? new Container()
        : new Container(
            child: new Text(
              eventViewModel.actionDes,
              style: VCommonStyles.smallSubText,
              maxLines: 3,
            ),
            margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
            alignment: Alignment.topLeft);

    Widget userImage = (needImage)
        ? new VWIconWidget(
            padding: const EdgeInsets.only(top: 0.0, right: 5.0, left: 0.0),
            width: 30.0,
            height: 30.0,
            image: eventViewModel.actionUserPic,
            onPressed: () {
//              VNavigatorUtils.goPerson(context, eventViewModel.actionUser);
            })
        : Container();
    return new Container(
      child: new VWCardItem(
          child: new FlatButton(
              onPressed: onPressed,
              child: new Padding(
                padding: new EdgeInsets.only(left: 0.0, top: 10.0, right: 0.0, bottom: 10.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        userImage,
                        new Expanded(child: new Text(eventViewModel.actionUser, style: VCommonStyles.smallTextBold)),
                        new Text(eventViewModel.actionTime, style: VCommonStyles.smallSubText),
                      ],
                    ),
                    new Container(
                        child: new Text(eventViewModel.actionTarget, style: VCommonStyles.smallTextBold),
                        margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
                        alignment: Alignment.topLeft),
                    des,
                  ],
                ),
              ))),
    );
  }
}
