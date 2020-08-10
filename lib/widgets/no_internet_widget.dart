import 'package:albums/themes/colors.dart';
import 'package:albums/themes/paddings.dart';
import 'package:albums/themes/strings.dart';
import 'package:flutter/material.dart';

import 'app_rounded_text_button.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  final VoidCallback retry;

  const NoInternetConnectionWidget({Key key, @required this.retry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Align(
        child: Container(
          margin: EdgeInsets.all(AppPaddings.defaultPadding),
          padding: EdgeInsets.all(AppPaddings.smallPadding),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(
              color: AppColors.lightGrey,
            ),
            borderRadius: AppPaddings.defaultRadius,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(AppStrings.noInternet,
                    style: Theme.of(context).textTheme.subtitle1),
              ),
              AppRoundedTextButton(
                text: AppStrings.retry,
                onTap: retry,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
