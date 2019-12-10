import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker/models/job.dart';

void main() {
  group('fromMap', () {
    test('null data', () {
      final job = Job.fromMap(null);
      expect(job, null);
    });
  });

  test('job with all properties', () {
    final job = Job.fromMap({
      'name': 'Blogging',
      'ratePerHour': 10,
      'id': 'abc'
    });
    expect(job, Job(name: 'Blogging', ratePerHour: 10, id: 'abc'));
  });

  test('missing name', () {
      final job = Job.fromMap({
        'ratePerHour': 10,
      });
      expect(job, null);
    });
}
