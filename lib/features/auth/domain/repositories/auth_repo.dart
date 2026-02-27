import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/login_request_model.dart';
import '../../data/models/register_request_model.dart';

abstract class AuthRepo {
  Future<AuthResponse> login(LoginRequestModel request);
  Future<AuthResponse> register(RegisterRequestModel request);
  Future<void> logout();
}
