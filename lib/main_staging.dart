// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:fitness/app/app.dart';
import 'package:fitness/bootstrap.dart';
import 'package:fitness/data/health_client.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final _healthClient = HealthClient();
  bootstrap(
    () => App(
      healthClient: _healthClient,
    ),
  );
}
