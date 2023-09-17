import 'package:collection/collection.dart';

void main() {
  Map<String, double> data = {
    "0-Kembung-Busuk": 0.0001750736846588552,
    "1-Kembung-Sangat Busuk": 0.000002472417008902994,
    "2-Kembung-Sangat Segar": 0.0011562493164092302,
    "3-Kembung-Segar": 0.0025874434504657984,
    "4-Selar Como-Busuk": 9.509838250210123e-9,
    "5-Selar Como-Sangat Busuk": 3.1509772568938388e-9,
    "6-Selar Como-Sangat Segar": 1.4792506419780693e-7,
    "7-Selar Como-Segar": 1.692084055093801e-7
  };
  var at = getTopProbability(data);
  var values = data.values;
  var result = values.reduce((sum, element) => sum + element);
  print(result * 100);
  print(at.value * 100);
}

MapEntry<String, double> getTopProbability(Map<String, double> labeledProb) {
  var pq = PriorityQueue<MapEntry<String, double>>(compare);
  pq.addAll(labeledProb.entries);

  return pq.first;
}

int compare(MapEntry<String, double> e1, MapEntry<String, double> e2) {
  if (e1.value > e2.value) {
    return -1;
  } else if (e1.value == e2.value) {
    return 0;
  } else {
    return 1;
  }
}
