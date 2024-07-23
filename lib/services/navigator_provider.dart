// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// (https://github.com/rrousselGit/riverpod/issues/268)
final navigatorKey = GlobalKey<NavigatorState>();
final navigatorKeyProvider = Provider((_) => navigatorKey);
