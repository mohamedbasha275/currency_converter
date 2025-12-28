enum Endpoint {
  convertCurrency('fetch-one'),
  getCurrencies('currencies'),
  getCurrenciesHistory('time-series');
  final String path;
  const Endpoint(this.path);
}

extension EndpointExtension on Endpoint {
  String get value => path;
}
