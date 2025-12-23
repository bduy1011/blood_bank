enum UserRole {
  admin,
  manager,
  user,
  hospital,
  userRegister;

  int get value {
    switch (this) {
      case UserRole.admin:
        return 10;
      case UserRole.manager:
        return 20;
      case UserRole.user:
        return 30;
      case UserRole.hospital:
        return 40;
      case UserRole.userRegister:
        return 0;
    }
  }
}
