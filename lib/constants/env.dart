abstract class Env {
  static Env? _instance;

  static Env get instance => _instance ?? (_instance = _envs);

  static Env get _envs {
    final envs = <String, Env>{
      "prod": _Production(),
      "dev": _Development(),
    };
    const env = String.fromEnvironment("env");
    return envs[env] ?? _Development();
  }

  abstract final String _endpoint;

  static String get endpoint => instance._endpoint;
}

class _Production extends Env {
  @override
  final String _endpoint = "https://us-central1-mrmelawi-cf81b.cloudfunctions.net";
}

class _Development extends Env {
  @override
  final String _endpoint = "https://us-central1-mrmelawi-cf81b.cloudfunctions.net";
}
