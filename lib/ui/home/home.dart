import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/fit/fit_store.dart';
import 'package:boilerplate/ui/home/chart.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_admob/firebase_admob.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

const String testDevice = 'YOUR_DEVICE_ID';

class _HomeScreenState extends State<HomeScreen> {
  final _fitStore = FitStore();

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    RewardedVideoAd.instance.listener = (
      RewardedVideoAdEvent event, {
      String rewardType,
      int rewardAmount,
    }) {
      print("RewardedVideoAd event $event");
      print("Reward $rewardAmount");
    };
    _fitStore.getFits();
  }

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['fit', 'health', 'enviroment', 'sport'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: false,
    nonPersonalizedAds: true,
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.fullBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
              child: Observer(
                builder: (context) {
                  return _fitStore.loading
                      ? Container()
                      : Center(
                          child: Container(
                            height: 150,
                            width: 150,
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        _fitStore?.fits?.points
                                                ?.floor()
                                                ?.toString() ??
                                            '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .display2,
                                      ),
                                      Text(
                                        'points this month',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 150,
                                  width: 150,
                                  child: CircularProgressIndicator(
                                    value: _fitStore?.fits?.points ??
                                        1.0 / 10000.0,
                                    strokeWidth: 8,
                                    valueColor: AlwaysStoppedAnimation(
                                        Theme.of(context).primaryColor),
                                    backgroundColor: Theme.of(context)
                                        .primaryColor
                                        .withAlpha(128),
                                    semanticsValue: '120',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Observer(
                builder: (context) {
                  return _fitStore.loading
                      ? Container()
                      : HomeChart(fitStore: _fitStore);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
                top: 64,
                bottom: 16,
              ),
              child: Text(
                'Journal',
                style: Theme.of(context).textTheme.display2,
              ),
            ),
            Expanded(
              child: Observer(
                builder: (context) {
                  return _fitStore.loading
                      ? CustomProgressIndicatorWidget()
                      : Material(child: _buildListView());
                },
              ),
            ),
            Observer(
              name: 'error',
              builder: (context) {
                return _fitStore.success
                    ? Container()
                    : showErrorMessage(
                        context,
                        _fitStore.errorStore.errorMessage,
                      );
              },
            )
          ],
        ),
      ),
      appBar: _buildAppBar(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        '',
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            SharedPreferences.getInstance().then((preference) {
              preference.setBool(Preferences.is_logged_in, false);
              Navigator.of(context).pushReplacementNamed(Routes.login);
            });
          },
          icon: Icon(
            Icons.person,
          ),
        )
      ],
    );
  }

  Widget _buildListView() {
    return _fitStore.fits != null
        ? ListView.separated(
            itemCount: _fitStore.fits.fitDailies.length,
            separatorBuilder: (context, position) {
              return Divider();
            },
            itemBuilder: (context, position) {
              var daily = _fitStore.fits.fitDailies[position];
              return ListTile(
                title: Text(
                  DateFormat.yMMMMd().format(
                    daily.date,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  '${daily?.points?.toInt() ?? ''} points, '
                  '${daily.steps} steps',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(context).textTheme.body1,
                ),
              );
            },
          )
        : Center(child: Text('No posts found'));
  }

  // General Methods:-----------------------------------------------------------
  showErrorMessage(BuildContext context, String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null) {
        FlushbarHelper.createError(
          message: message,
          title: 'Error',
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return Container();
  }
}

class HomeChart extends StatelessWidget {
  HomeChart({
    Key key,
    @required FitStore fitStore,
  })  : _fitStore = fitStore,
        super(key: key);

  final FitStore _fitStore;

  @override
  Widget build(BuildContext context) {
    final colorFn = (_, __) => charts.ColorUtil.fromDartColor(
          Theme.of(context).textTheme.body1.color.withAlpha(128),
        );
    return Container(
      height: 100,
      child: TimeSeriesBar(
        [
          new charts.Series<TimeSeriesSales, DateTime>(
            id: 'Sales',
            colorFn: colorFn,
            fillColorFn: colorFn,
            domainFn: (TimeSeriesSales sales, _) => sales.time,
            measureFn: (TimeSeriesSales sales, _) => sales.sales,
            data: _fitStore.fits?.fitDailies
                    ?.map(
                      (d) => TimeSeriesSales(
                        d.date,
                        d.points.toInt(),
                      ),
                    )
                    ?.toList() ??
                [],
          )
        ],
      ),
    );
  }
}
