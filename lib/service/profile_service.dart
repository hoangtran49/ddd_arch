import 'package:ddd_arch/domain/models/user/user.dart';
import 'package:ddd_arch/domain/repository/user_repo.dart';
import 'package:ddd_arch/infra/database/objectbox_data_base/token_dao.dart';
import 'package:injectable/injectable.dart';

@singleton
class ProfileService {
  const ProfileService(this.userRepo);
  final UserRepo userRepo;

  Future<User?> getCurrentUser() async {
    return userRepo.getCurrentUser();
  }

  Future<bool> isLogin() async {
    final currentUser = await userRepo.getCurrentUser();
    return currentUser != null;
  }
}
