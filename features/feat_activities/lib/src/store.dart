import 'dart:async';

import 'package:feat_activities/src/api.dart';
import 'package:feat_auth/feat_auth.dart';
import 'package:lib_di/lib_di.dart';
import 'package:mobx/mobx.dart';

part 'store.g.dart';

class ActivitiesStore = _ActivitiesStore with _$ActivitiesStore;

abstract class _ActivitiesStore with Store {
  final ErrorStore errorStore;
  final GoogleSignInStore googleSignInStore;
  final ActivitiesApi activitiesApi;

  _ActivitiesStore(
    this.errorStore,
    this.googleSignInStore,
    this.activitiesApi,
  );

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @action
  Future sendData() async {
    final authentication = await googleSignInStore.currentUser.authentication;
    final email = googleSignInStore.currentUser.email;
    await activitiesApi.getFitActivities(authentication.accessToken, email);
  }

  @action
  Future close() async {}
}
