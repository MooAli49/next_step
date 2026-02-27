import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/app_secret.dart';
import 'core/services/cache_service.dart';
import 'core/utils/dependency_injection.dart';
import 'next_step.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  setupDependencyInjection();

  await Supabase.initialize(
    url: AppSecret.supabaseUrl,
    anonKey: AppSecret.supabaseAnonKey,
  );

  runApp(const NextStep());
}

Future<void> initServices() async {
  await Get.putAsync(() => CacheService().init());
}
