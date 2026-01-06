enum Endpoint {
  convertCurrency('latest'),
  getCurrencies('symbols'),
  getCurrenciesHistory('timeseries');
  final String path;
  const Endpoint(this.path);
}

extension EndpointExtension on Endpoint {
  String get value => path;
}
