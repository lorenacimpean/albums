import 'package:albums/themes/colors.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:albums/widgets/app_rounded_text_button.dart';
import 'package:flutter/material.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
                vertical: AppPaddings.defaultPadding,
                horizontal: AppPaddings.extraLargePadding),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(
                color: AppColors.lightGrey,
              ),
              borderRadius: AppPaddings.defaultRadius,
            ),
            child: Text(AppStrings.noInternet,
                style: Theme.of(context).textTheme.subtitle1),
          ),
          AppRoundedTextButton(text: null, onTap: () => {}),
        ],
      ),
    );
  }
}
