import 'package:flutter/material.dart';
import '../components/top_panel_component.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool remember = false;
  bool isLoading = false;

  // ❌ don't use const with controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ✅ login logic
  void handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Validate using Form
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      // TODO: Replace this with API call
      await Future.delayed(const Duration(seconds: 2));

      // Example success check (demo)
      if (email == "admin@gmail.com" && password == "123456") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login Success ✅")),
        );

        // TODO: Navigate to dashboard page
        // Navigator.pushReplacement(context,
        // MaterialPageRoute(builder: (_) => const HomePage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid email or password ❌")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 60,
            vertical: 20,
          ),
          child: Column(
            children: [
              const TopPanelComponent(),
              const SizedBox(height: 30),

              Expanded(
                child: isMobile
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            _leftIllustration(isMobile),
                            const SizedBox(height: 30),
                            _rightForm(isMobile),
                          ],
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(child: _leftIllustration(isMobile)),
                          const SizedBox(width: 40),
                          Expanded(child: _rightForm(isMobile)),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _leftIllustration(bool isMobile) {
    return Center(
      child: Container(
        height: isMobile ? 250 : 420,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade100,
        ),
        child: Center(
          child: Image.asset(
            "assets/images/loginPage.png",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _rightForm(bool isMobile) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: isMobile ? double.infinity : 420,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 18,
              spreadRadius: 3,
            )
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Welcome back, Chief",
                style: TextStyle(
                  fontSize: isMobile ? 24 : 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Welcome back! Please enter your details.",
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 30),

              // ✅ EMAIL
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  final email = value?.trim() ?? "";

                  if (email.isEmpty) {
                    return "Email is required";
                  }

                  // simple email validation
                  if (!email.contains("@") || !email.contains(".")) {
                    return "Enter a valid email";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 18),

              // ✅ PASSWORD
              TextFormField(
                controller: passwordController,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: const UnderlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                    ),
                  ),
                ),
                validator: (value) {
                  final pass = value?.trim() ?? "";

                  if (pass.isEmpty) {
                    return "Password is required";
                  }

                  if (pass.length < 6) {
                    return "Password must be at least 6 characters";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 18),

              // Forgot password row
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to ForgotPasswordPage
                    },
                    child: const Text(
                      "Forgot Password",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 18),

              // ✅ LOGIN BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: isLoading ? null : handleLogin,
                  child: isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Log in",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
