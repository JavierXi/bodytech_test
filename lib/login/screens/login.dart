import 'package:bodytech/homepage/screens/homepage.dart';
import 'package:bodytech/widgets/buildfieldwidget.dart';
import 'package:bodytech/signup/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = true;
  final logo = 'assets/logo_transparent.png';

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 70, 30, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'VIVE LA\nEXPERIENCIA\nBODYTECH',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 170),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      BuildFieldWidget(
                        controller: emailController,
                        obscureText: false,
                        capitalization: TextCapitalization.none,
                        suffixIcon: emailController.text.isEmpty
                            ? Container(width: 0)
                            : IconButton(
                                onPressed: () => emailController.clear(),
                                icon: const Icon(Icons.close),
                                color: Colors.grey.shade900,
                              ),
                        hintText: 'Correo electrónico',
                        hintColor: Colors.grey.shade900,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]')
                                  .hasMatch(value)) {
                            return 'Ingresa un correo válido';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 0),
                      BuildFieldWidget(
                        controller: passwordController,
                        obscureText: isPasswordVisible,
                        capitalization: TextCapitalization.none,
                        suffixIcon: passwordController.text.isEmpty
                            ? Container(width: 0)
                            : IconButton(
                                icon: isPasswordVisible
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                                color: Colors.grey.shade900,
                                onPressed: () => setState(() =>
                                    isPasswordVisible = !isPasswordVisible),
                              ),
                        hintText: 'Contraseña',
                        hintColor: Colors.grey.shade900,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[A-Z a-z 0-9]').hasMatch(value)) {
                            return 'Ingresa una contraseña válida';
                          }
                          if (value.length < 8) {
                            return 'Ingresa mínimo 8 caracteres';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 40),
                      TextButton(
                        child: const Text(
                          'Olvidé mis credenciales',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xfff86d66),
                              Color(0xffe0702a),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ElevatedButton(
                          child: const Text('ENTRENAR'),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                            onPrimary: Colors.white,
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              login();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 50),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'No tengo cuenta, ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: 'crear una.',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUpPage(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 70),
                      Image.asset(
                        logo,
                        width: 80,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future login() async {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: SizedBox(
          height: 45,
          width: 45,
          child: CircularProgressIndicator(
            color: Color(0xffe0702a),
          ),
        ),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final tokenResult = FirebaseAuth.instance.currentUser!;
      final idToken = tokenResult.uid;
      if (idToken.isNotEmpty) {
        await Future.delayed(const Duration(milliseconds: 1500));
        Navigator.pop(context);
        showDialog(
          barrierColor: Colors.black.withOpacity(0.2),
          barrierDismissible: false,
          context: context,
          builder: (context) => Center(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: const [
                SizedBox(
                  height: 45,
                  width: 45,
                  child: CircularProgressIndicator(
                    color: Color(0xffe0702a),
                    value: 1,
                  ),
                ),
                Icon(
                  Icons.done_rounded,
                  size: 35,
                  color: Color(0xffe0702a),
                ),
              ],
            ),
          ),
        );
        await Future.delayed(const Duration(milliseconds: 1000));
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'wrong-password') {
        await Future.delayed(const Duration(milliseconds: 1500));
        Navigator.pop(context);
        showDialog(
          barrierColor: Colors.black.withOpacity(0.2),
          barrierDismissible: false,
          context: context,
          builder: (context) => Center(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: const [
                SizedBox(
                  height: 45,
                  width: 45,
                  child: CircularProgressIndicator(
                    color: Color(0xfff86d66),
                    value: 1,
                  ),
                ),
                Icon(
                  Icons.close_rounded,
                  size: 35,
                  color: Color(0xfff86d66),
                ),
              ],
            ),
          ),
        );
        await Future.delayed(const Duration(milliseconds: 1000));
        Navigator.pop(context);
        errorMessage('Tu contraseña es incorrecta');
      } else if (error.code == 'user-not-found') {
        await Future.delayed(const Duration(milliseconds: 1500));
        Navigator.pop(context);
        showDialog(
          barrierColor: Colors.black.withOpacity(0.2),
          barrierDismissible: false,
          context: context,
          builder: (context) => Center(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: const [
                SizedBox(
                  height: 45,
                  width: 45,
                  child: CircularProgressIndicator(
                    color: Color(0xfff86d66),
                    value: 1,
                  ),
                ),
                Icon(
                  Icons.close_rounded,
                  size: 35,
                  color: Color(0xfff86d66),
                ),
              ],
            ),
          ),
        );
        await Future.delayed(const Duration(milliseconds: 1000));
        Navigator.pop(context);
        errorMessage('Aún no estás registrado');
      }
    }
  }

  void errorMessage(message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xfff86d66),
        behavior: SnackBarBehavior.fixed,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.only(
          bottom: 15,
          top: 15,
        ),
        duration: const Duration(milliseconds: 2500),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
