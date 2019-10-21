import 'package:flutter/material.dart';
import 'package:vincent_flutter/view/style/VIconConstant.dart';
import 'package:vincent_flutter/view/widget/vw_network_cache_image.dart';

class VWIconWidget extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;

  VWIconWidget({this.image, this.onPressed, this.width = 30.0, this.height = 30.0, this.padding});

  @override
  Widget build(BuildContext context) {
    return new RawMaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding ?? const EdgeInsets.only(top: 4.0, right: 5.0, left: 5.0),
        constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
        child: new ClipOval(
          child: FadeInImage(
            placeholder: AssetImage(
              VIconConstant.DEFAULT_USER_ICON,
            ),
            image: VWNetworkCacheImage(image),
            //预览图
            fit: BoxFit.fitWidth,
            width: width,
            height: height,
          ),
        ),
        onPressed: onPressed);
  }
}
