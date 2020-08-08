import 'dart:async';
import 'package:lib_services/lib_services.dart';
import 'package:lib_shared/lib_shared.dart';
import 'package:mobx/mobx.dart';

part 'session_evaluation_store.g.dart';

class ServiceSessionEvaluationStore = _ServiceSessionEvaluationStore
    with _$ServiceSessionEvaluationStore;

abstract class _ServiceSessionEvaluationStore with Store {
  final ErrorStore errorStore;
  final LoadingStore loadingStore;

  ServicesClient client;

  _ServiceSessionEvaluationStore(
      this.errorStore,
      this.loadingStore,
      this.client,
      );

  @observable
  ServiceSessionEvaluation evaluation;

  @action
  Future create(ServiceSession session) async {
    final request = UpdateServiceSessionRequest()
      ..payload = (session
        ..finishedAt = Timestamp.fromDateTime(DateTime.now())
        ..evaluation = evaluation);
    final response = await client.updateServiceSession(request);
    loadingStore.success = true;
  }
}