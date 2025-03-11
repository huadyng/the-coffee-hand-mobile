part of 'login_view.dart';

mixin LoginViewMixin on State<LoginView> {
  //Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      // Bước 1: Đăng nhập Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // Người dùng hủy đăng nhập

      // Bước 2: Lấy token từ tài khoản Google
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Bước 3: Tạo credential cho Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Bước 4: Đăng nhập vào Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        print('Đăng nhập Google thành công: ${user.email}');
        // Điều hướng đến màn hình chính sau khi đăng nhập thành công
        if (mounted) {
          Navigator.pop(context); // Quay lại màn hình trước đó
        }
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.message}');
      _showErrorDialog("Authentication Error", e.message ?? "An unknown error occurred.");
    } catch (e) {
      print('General error: $e');
      _showErrorDialog("Error", "An unknown error occurred.");
    }
  }

  // Hàm hiển thị dialog lỗi
  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
