import 'package:feat_auth/feat_auth.dart';
import 'package:feat_chat/feat_chat.dart';
import 'package:feat_ion/feat_ion.dart';
import 'package:feat_feed/feat_feed.dart';
import 'package:feat_journal/feat_journal.dart';
import 'package:feat_health/feat_health.dart';
import 'package:feat_notifications/feat_notifications.dart';
import 'package:feat_onboarding/feat_onboarding.dart';
import 'package:feat_profile/feat_profile.dart';
import 'package:feat_storage/feat_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grpc/grpc.dart';
import 'package:lib_shared/lib_shared.dart';
import 'package:lib_lego/lib_lego.dart';
import 'package:lib_services/lib_services.dart';
import 'package:feat_services/feat_services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'routes.dart';

class AppInjector extends StatefulWidget {
  final Widget child;

  const AppInjector({Key key, this.child}) : super(key: key);

  @override
  _AppInjectorState createState() => _AppInjectorState();
}

final router = Router();

class _AppInjectorState extends State<AppInjector> {
  final channel = ClientChannel(
    'swanly.qa.api.kodesmil.com',
    port: 443,
    options: const ChannelOptions(
      credentials: ChannelCredentials.secure(),
    ),
  );

  @override
  void initState() {
    Routes.configureRoutes(router);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppStateNotifier(),
        ),
        ProxyProvider0(
          update: (_, __) => FirebaseAuth.instance,
        ),
        ProxyProvider0(
          update: (_, __) => StorageStore(
            ErrorStore(),
          ),
        ),
        ProxyProvider0(
          update: (_, __) {
            return IonHelper();
          },
        ),
        ProxyProvider<FirebaseAuth, UserStore>(
          update: (_, dep, old) {
            return old ?? UserStore(dep);
          },
        ),
        ProxyProvider0(
          update: (_, __) => AuthStorage(
            SharedPreferences.getInstance(),
          ),
        ),
        ProxyProvider0(
          update: (_, __) => GoogleSignIn(
            scopes: <String>[
              'email',
              'profile',
              'openid',
              'https://www.googleapis.com/auth/fitness.activity.read',
              'https://www.googleapis.com/auth/fitness.body.read',
              'https://www.googleapis.com/auth/fitness.location.read',
              'https://www.googleapis.com/auth/fitness.nutrition.read',
            ],
          ),
        ),
        ProxyProvider3<FirebaseAuth, GoogleSignIn, UserStore, LoginStore>(
          update: (_, dep, dep2, dep3, __) => LoginStore(
            ErrorStore(),
            LoginErrorStore(),
            dep,
            dep2,
            dep3,
          ),
        ),
        ProxyProvider2<FirebaseAuth, UserStore, SignUpStore>(
          update: (_, dep, dep2, __) => SignUpStore(
            ErrorStore(),
            SignUpErrorStore(),
            dep,
            dep2,
          ),
        ),
        ProxyProvider<AuthStorage, OnboardingStore>(
          update: (_, dep, __) => OnboardingStore(
            dep,
          ),
        ),
        ProxyProvider<UserStore, CallOptions>(
          update: (_, store, __) {
            return CallOptions(
              providers: [
                (metadata, url) async {
                  if (store.user == null) return;
                  final idToken = await store.user.getIdToken();
                  metadata['authorization'] = 'Bearer ${idToken.token}';
                },
              ],
            );
          },
        ),
        ProxyProvider<CallOptions, NotificationSettingsClient>(
          update: (_, dep, __) => NotificationSettingsClient(
            channel,
            options: dep,
          ),
        ),
        ProxyProvider<CallOptions, NotificationDevicesClient>(
          update: (_, dep, __) => NotificationDevicesClient(
            channel,
            options: dep,
          ),
        ),
        ProxyProvider<CallOptions, ServicesClient>(
          update: (_, dep, __) => ServicesClient(
            channel,
            options: dep,
          ),
        ),
        ProxyProvider<CallOptions, ProfilesClient>(
          update: (_, dep, __) => ProfilesClient(
            channel,
            options: dep,
          ),
        ),
        ProxyProvider<CallOptions, JournalClient>(
          update: (_, dep, __) => JournalClient(
            channel,
            options: dep,
          ),
        ),
        ProxyProvider<CallOptions, HealthClient>(
          update: (_, dep, __) => HealthClient(
            channel,
            options: dep,
          ),
        ),
        ProxyProvider<CallOptions, GroupsClient>(
          update: (_, dep, __) => GroupsClient(
            channel,
            options: dep,
          ),
        ),
        ProxyProvider<CallOptions, FeedArticlesClient>(
          update: (_, dep, __) => FeedArticlesClient(
            channel,
            options: dep,
          ),
        ),
        ProxyProvider<CallOptions, FeedArticleDetailsClient>(
          update: (_, dep, __) => FeedArticleDetailsClient(
            channel,
            options: dep,
          ),
        ),
        ProxyProvider<CallOptions, FeedArticlesClient>(
          update: (_, dep, __) => FeedArticlesClient(
            channel,
            options: dep,
          ),
        ),
        ProxyProvider<CallOptions, ChatClient>(
          update: (_, dep, __) => ChatClient(
            channel,
            options: dep,
          ),
        ),
        ProxyProvider2<UserStore, ProfilesClient, ProfileStore>(
          update: (_, dep, dep2, __) => ProfileStore(
            ErrorStore(),
            dep,
            dep2,
          ),
        ),
        ProxyProvider<NotificationDevicesClient, NotificationDevicesStore>(
          update: (_, dep, __) => NotificationDevicesStore(
            ErrorStore(),
            dep,
          ),
        ),
        ProxyProvider2<UserStore, NotificationSettingsClient,
            NotificationSettingsStore>(
          update: (_, dep, dep2, __) => NotificationSettingsStore(
            ErrorStore(),
            dep,
            dep2,
          ),
        ),
        ProxyProvider<JournalClient, JournalStore>(
          update: (_, dep, __) => JournalStore(
            ErrorStore(),
            dep,
          ),
        ),
        ProxyProvider<HealthClient, MenstruationDailyEntryStore>(
          update: (_, dep, __) => MenstruationDailyEntryStore(
            ErrorStore(),
            LoadingStore(),
            dep,
          ),
        ),
        ProxyProvider<HealthClient, MenstruationPersonalInfoStore>(
          update: (_, dep, __) => MenstruationPersonalInfoStore(
            ErrorStore(),
            LoadingStore(),
            dep,
          ),
        ),
        ProxyProvider<ServicesClient, ServiceApplicationStore>(
          update: (_, dep, __) => ServiceApplicationStore(
            ErrorStore(),
            LoadingStore(),
            dep,
          ),
        ),
        ProxyProvider<ServicesClient, ServiceSessionStore>(
          update: (_, dep, __) => ServiceSessionStore(
            ErrorStore(),
            LoadingStore(),
            dep,
          ),
        ),
        ProxyProvider<ServicesClient, ServiceOfferStore>(
          update: (_, dep, __) => ServiceOfferStore(
            ErrorStore(),
            LoadingStore(),
            dep,
          ),
        ),
        ProxyProvider<ServicesClient, ServiceSessionEvaluationStore>(
          update: (_, dep, __) => ServiceSessionEvaluationStore(
            ErrorStore(),
            LoadingStore(),
            dep,
          ),
        ),
        ProxyProvider<HealthClient, MenstruationPersonalInfoStore>(
          update: (_, dep, __) => MenstruationPersonalInfoStore(
            ErrorStore(),
            LoadingStore(),
            dep,
          ),
        ),
        ProxyProvider<FeedArticlesClient, FeedStore>(
          update: (_, dep, __) => FeedStore(
            ErrorStore(),
            dep,
          ),
        ),
        ProxyProvider2<UserStore, ChatClient, ChatStore>(
          update: (_, dep, dep2, __) => ChatStore(
            ErrorStore(),
            dep,
            dep2,
          ),
        ),
      ],
      child: widget.child,
    );
  }
}
