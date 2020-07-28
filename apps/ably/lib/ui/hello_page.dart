import 'package:feat_feed/feat_feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lib_lego/lib_lego.dart';

class HelloPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KsAppBar(
        title: 'Hi!',
        context: context,
      ),
      body: ListView(
        children: [
          SizedBox(height: 25),
          FeedScroll(
            title: 'Daily Feed',
            feedKey: 'daily',
          ),
          FeedScroll(
            title: 'Quick Relief',
            feedKey: 'relief',
          ),
          FeedScroll(
            title: 'Daily Updates',
            feedKey: 'updates',
          ),
          KsSpace.xl(),
        ],
      ),
    );
  }
}
