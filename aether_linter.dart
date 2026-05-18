// Aether Architecture Linter — transparent outcome analyzer.
// Run from the project root:  dart aether_linter.dart
//
// It executes `flutter analyze` and `flutter test test/raid_concurrency_test.dart`,
// then writes ARCHITECTURE_REPORT.md describing the outcomes.

import 'dart:io';

Future<void> main() async {
  stdout..writeln('===================================================')
  ..writeln('Aether Architecture Linter (Diagnostic Mode)')
  ..writeln('===================================================');

  final File pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) {
    stdout..writeln('CRITICAL ERROR: Not running in a Flutter project root.')
    ..writeln('HEALING: cd into your project directory before running.');
    return;
  }

  final File reportFile = File('ARCHITECTURE_REPORT.md');
  final StringBuffer out = StringBuffer()
    ..writeln('# Aether Diagnostic Report')
    ..writeln();

  // 1. Strict Lints
  stdout.writeln('Running Diagnostic: Code Quality (flutter analyze)...');
  try {
    final ProcessResult analyze =
        await Process.run('flutter', <String>['analyze']);
    if (analyze.exitCode == 0) {
      stdout.writeln('Linter: PASS');
      out
        ..writeln('### 1. Code Quality')
        ..writeln('PASS: Zero static analysis warnings.');
    } else {
      stdout.writeln('Linter: FAIL');
      out
        ..writeln('### 1. Code Quality')
        ..writeln('FAIL: Static analysis found issues.')
        ..writeln()
        ..writeln('```')
        ..writeln(analyze.stdout)
        ..writeln(analyze.stderr)
        ..writeln('```')
        ..writeln()
        ..writeln(
          'HEALING ACTION: Resolve every warning. Did you specify types? '
          'Did you await all Futures?',
        );
    }
  } on ProcessException catch (e) {
    stdout.writeln('CRITICAL ERROR: Could not run flutter analyze: $e');
    return;
  }

  // 2. Outcome Verification (Tests)
  stdout.writeln('Running Diagnostic: Concurrency Check (flutter test)...');
  final File testFile = File('test/raid_concurrency_test.dart');

  if (!testFile.existsSync()) {
    stdout.writeln('Tests: FAIL (raid_concurrency_test.dart missing)');
    out
      ..writeln()
      ..writeln('### 2. Concurrency Outcome')
      ..writeln('FAIL: Missing test file.')
      ..writeln()
      ..writeln(
        'HEALING ACTION: Place raid_concurrency_test.dart in the test/ '
        'directory.',
      );
  } else {
    try {
      final ProcessResult testResult = await Process.run(
        'flutter',
        <String>['test', 'test/raid_concurrency_test.dart'],
      );
      if (testResult.exitCode == 0) {
        stdout.writeln('Tests: PASS');
        out
          ..writeln()
          ..writeln('### 2. Concurrency Outcome')
          ..writeln('PASS: Your architecture survived the Thundering Herd.');
      } else {
        stdout.writeln('Tests: FAIL');
        out
          ..writeln()
          ..writeln('### 2. Concurrency Outcome')
          ..writeln(
            'FAIL: The 50-request blast failed to yield exactly 15 slots.',
          )
          ..writeln()
          ..writeln('```')
          ..writeln(testResult.stdout)
          ..writeln(testResult.stderr)
          ..writeln('```')
          ..writeln()
          ..writeln(
            'HEALING ACTION: Re-read the failure logs. Did joinRaid() '
            'correctly handle the race condition? Are you using locks or '
            'transactions?',
          );
      }
    } on ProcessException catch (e) {
      stdout.writeln('CRITICAL ERROR: Could not execute flutter test: $e');
    }
  }

  try {
    reportFile.writeAsStringSync(out.toString());
    stdout..writeln('---------------------------------------------------')
    ..writeln('Report saved to ARCHITECTURE_REPORT.md')
    ..writeln('Read the report for HEALING ACTIONS.')
    ..writeln('---------------------------------------------------');
  } on FileSystemException catch (e) {
    stdout.writeln('Could not write to ARCHITECTURE_REPORT.md: $e');
  }
}
