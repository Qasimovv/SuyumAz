import 'package:admin_suyumaz_app/services/sizeconfig.dart';
import 'package:admin_suyumaz_app/utils/constants/text_styles.dart';
import 'package:admin_suyumaz_app/utils/themes/theme.dart';
import 'package:flutter/material.dart';

Widget bottomButton(
    {@required BuildContext context,
    @required String buttomName,
    @required Function onPressed,
    double height = 72}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      color: Themes.primaryColor,
      height: SizeConfig.getHeightRatio(height),
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          "$buttomName",
          style: CustomTextStyles.white18,
        ),
      ),
    ),
  );
}
