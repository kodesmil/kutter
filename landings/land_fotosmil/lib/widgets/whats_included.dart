import 'package:flutter/material.dart';
import 'package:kodesmil_locale/localizations.dart';
import 'package:lib_lego/spaces.dart';
import 'package:lib_lego/texts.dart';

import 'features.dart';

class WhatsIncludedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          KsSpace.xxlH(),
          KsText.display3(KsLoc.of(context).fsWhatsIncluded()),
          ...getFeatures(context),
          KsSpace.xxlH(),
        ],
      ),
    );
  }
}
