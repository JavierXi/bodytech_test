import 'package:bodytech/homepage/screens/homepage.dart';
import 'package:bodytech/widgets/buildfieldwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isPasswordVisible = true;
  bool confirmPasswordVisible = true;
  final logo = 'assets/logo_transparent.png';

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
    confirmPasswordController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    size: 50,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CREAR\nCUENTA',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 120),
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
                        const SizedBox(height: 10),
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
                          hintText: 'Contraseña (Min. 6 caracteres)',
                          hintColor: Colors.grey.shade900,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^[A-Z a-z 0-9]').hasMatch(value)) {
                              return 'Ingresa una contraseña válida';
                            }
                            if (value.length < 6) {
                              return 'Ingresa mínimo 6 caracteres';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 10),
                        BuildFieldWidget(
                          controller: confirmPasswordController,
                          obscureText: confirmPasswordVisible,
                          capitalization: TextCapitalization.none,
                          suffixIcon: confirmPasswordController.text.isEmpty
                              ? Container(width: 0)
                              : IconButton(
                                  icon: confirmPasswordVisible
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  color: Colors.grey.shade900,
                                  onPressed: () => setState(() =>
                                      confirmPasswordVisible =
                                          !confirmPasswordVisible),
                                ),
                          hintText: 'Confirma tu contraseña',
                          hintColor: Colors.grey.shade900,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Confirma tu contraseña';
                            }
                            if (value != passwordController.text) {
                              return 'Las contraseñas no coinciden';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(height: 50),
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
                            child: const Text('CREAR CUENTA'),
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
                                signup();
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Al registrarme acpeto los ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: 'términos de uso ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'y ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: 'políticas de privacidad.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signup() async {
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
        await Future.delayed(const Duration(milliseconds: 2000));
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
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
        errorMessage('El correo ya se encuentra registrado');
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
