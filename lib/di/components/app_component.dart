import 'package:boilerplate/data/network/apis/posts/token_api.dart';
import 'package:boilerplate/data/post_repository.dart';
import 'package:boilerplate/di/modules/local_module.dart';
import 'package:boilerplate/di/modules/netwok_module.dart';
import 'package:boilerplate/main.dart';
import 'package:inject/inject.dart';

import 'app_component.inject.dart' as g;

/// The top level injector that stitches together multiple app features into
/// a complete app.
@Injector(const [NetworkModule, LocalModule])
abstract class AppComponent {
  @provide
  MyApp get app;

  static Future<AppComponent> create(
      NetworkModule networkModule,
      LocalModule localModule,
      ) async {
    return await g.AppComponent$Injector.create(
      networkModule,
      localModule,
    );
  }

  /// An accessor to RestClient object that an application may use.
  @provide
  Repository getRepository();

  @provide
  TokenApi getTokenApi();
}
