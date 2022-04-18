import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'auth.signInButton': 'Sign In',
          'auth.signInError': 'Login failed: email or password incorrect.',
          'auth.resetPasswordButton': 'Send Password Reset',
          'auth.emailFormField': 'Email',
          'auth.passwordFormField': 'Password',
          'auth.signInErrorTitle': 'Sign In Error',
          'auth.resetPasswordLabelButton': 'Forgot password?',
          'home.title': 'Home',
          'settings.title': 'Settings',
          'settings.language': 'Language',
          'settings.theme': 'Theme',
          'settings.signOut': 'Sign Out',
          'settings.dark': 'Dark',
          'settings.light': 'Light',
          'settings.system': 'System',
          'auth.signInonResetPasswordLabelButton': 'Sign In',
          'validator.email': 'Please enter a valid email address.',
          'validator.password': 'Password must be at least 6 characters.',
          'validator.notEmpty': 'This is a required field.',
          'auth.resetPasswordNoticeTitle': 'Password Reset Email Sent',
          'auth.resetPasswordNotice':
              'Check your email and follow the instructions to reset your password.',
          'auth.resetPasswordFailed': 'Password Reset Email Failed',
        },
        'es': {
          'auth.signInButton': 'Ingresar',
          'auth.resetPasswordButton': 'Enviar restablecimiento de contraseña',
          'auth.emailFormField': 'Correo electrónico',
          'auth.passwordFormField': 'Contraseña',
          'auth.signInErrorTitle': 'Error de inicio de sesión',
          'auth.resetPasswordLabelButton': 'Ha olvidado su contraseña?',
          'home.title': 'Inicio',
          'settings.title': 'Ajustes',
          'settings.language': 'Idioma',
          'settings.theme': 'Tema',
          'settings.signOut': 'Salida Segura',
          'settings.dark': 'Oscuro',
          'settings.light': 'Luz',
          'settings.system': 'Sistema',
          'auth.signInonResetPasswordLabelButton': 'Iniciar sesión',
          'validator.email':
              'Por favor, introduce una dirección de correo electrónico válida.',
          'validator.password':
              'La contraseña debe tener al menos 6 caracteres.',
          'validator.notEmpty': 'Este es un campo obligatorio.',
          'auth.resetPasswordNoticeTitle':
              'Restablecer contraseña de correo electrónico enviados',
          'auth.resetPasswordNotice':
              'Consultar su correo electrónico y siga las instrucciones para restablecer su contraseña.',
          'auth.resetPasswordFailed':
              'Restablecer contraseña de correo electrónico incorrecto',
        },
      };
}
