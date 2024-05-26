class FirebaseMessageParse {
  static String parseSignUpError(String error) {
    switch (error) {
      case 'email-already-in-use':
        return 'Email telah digunakan';
      case 'invalid-email':
        return 'Email tidak valid';
      case 'operation-not-allowed':
        return 'Tidak bisa membuat akun dengan email';
      case 'weak-password':
        return 'Kata sandi terlalu lemah';
      default:
        return 'Tidak dapat terhubung ke server';
    }
  }

  static String parseSignInError(String error) {
    switch (error) {
      case 'invalid-email':
        return 'Email tidak valid';
      case 'user-disabled':
        return 'Email telah dinonaktifkan';
      case 'user-not-found':
        return 'Email dan/atau kata sandi salah';
      case 'wrong-password':
        return 'Email dan/atau kata sandi salah';
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Email dan/atau kata sandi salah';
      default:
        return 'Tidak dapat terhubung ke server';
    }
  }

  static String parseForgetPasswordError(String error) {
    switch (error) {
      case 'auth/invalid-email':
        return 'Alamat email tidak valid';
// Thrown if the email address is not valid.
      case 'auth/missing-android-pkg-name':
        return 'Tidak dapat terhubung ke server';
// An Android package name must be provided if the Android app is required to be installed.
      case 'auth/missing-continue-uri':
        return 'Tidak dapat terhubung ke server';
// A continue URL must be provided in the request.
      case 'auth/missing-ios-bundle-id':
        return 'Tidak dapat terhubung ke server';
// An iOS Bundle ID must be provided if an App Store ID is provided.
      case 'auth/invalid-continue-uri':
        return 'Terjadi kesalahan';
// The continue URL provided in the request is invalid.
      case 'auth/unauthorized-continue-uri':
        return 'Tidak dapat terhubung ke server';
// The domain of the continue URL is not whitelisted. Whitelist the domain in the Firebase console.
      case 'auth/user-not-found':
        return 'User tidak ditemukan';
      default:
        return 'Tidak dapat terhubung ke server';
    }
  }
}
