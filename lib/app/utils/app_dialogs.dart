import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:ottaa_project_flutter/app/utils/constants.dart';

class _BaseDialogs {
  static showInformationDialog(String title, String content,
      {VoidCallback? callback}) {
    // assert(title != null && content != null);
    Get.dialog(AlertDialog(
      title: Text(title),
      content: Text(content),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0)),
      actions: [
        TextButton(
          child: Text(
            "Cerrar",
            style: TextStyle(color: kOTTAOrange),
          ),
          onPressed: () {
            callback?.call();
            Get.back();
          },
        )
      ],
    ));
  }
}

class AppDialogs {
  static showInformationDialog(String title, String content,
      {VoidCallback? callback}) {
    _BaseDialogs.showInformationDialog(title, content, callback: callback);
  }

  static showInvalidEmailDialog() {
    _BaseDialogs.showInformationDialog("¡Email no válido!",
        "El email debe tener el formato de ejemplo@correo.com");
  }

  static showUserNotFoundDialog() {
    _BaseDialogs.showInformationDialog(
        "¡Usuario no encontrado!", "Verifique los datos ingresados");
  }

  static showUndefinedErrorDialog() {
    _BaseDialogs.showInformationDialog(
        "¡Error Desconocido!", "Verifique los datos ingresados");
  }

  static showInvalidPasswordDialog() {
    _BaseDialogs.showInformationDialog(
        "¡Password incorrecto!", "Vuelva a intentar nuevamente");
  }

  static showEmptyPasswordDialog() {
    _BaseDialogs.showInformationDialog("¡El campo contraseña está vacío!",
        "Debe ingresar una contraseña con 8 o más caracteres");
  }

  static showEmptyNameDialog() {
    _BaseDialogs.showInformationDialog(
        "¡El campo nombre está vacío!", "Debe ingresar su nombre y apellido");
  }

  static showEmptyMarcaDialog() {
    _BaseDialogs.showInformationDialog(
        "¡El campo marca está vacío!", "Debe ingresar la marca del vehículo");
  }

  static showEmptyNombreDialog() {
    _BaseDialogs.showInformationDialog(
        "¡El campo modelo está vacío!", "Debe ingresar el modelo del vehículo");
  }

  static showEmptyPlacaDialog() {
    _BaseDialogs.showInformationDialog(
        "¡El campo placa está vacío!", "Debe ingresar la placa del vehículo");
  }

  static showEmailAlreadyExistsDialog() {
    _BaseDialogs.showInformationDialog("¡El email ingresado yá existe!",
        "Acceda por email y password a la aplicación");
  }

  static showUnknownErrorDialog() {
    _BaseDialogs.showInformationDialog("Se ha producido en error inesperado",
        "Contáctese con un administrador del sistema");
  }

  static showEmptyKilometrajeDialog() {
    _BaseDialogs.showInformationDialog("¡El campo kilometraje está vacío!",
        "Debe ingresar los kilometros actuales del vehiculo");
  }

  static showEmptyVehiculoDialog() {
    _BaseDialogs.showInformationDialog(
        "¡El campo vehículo está vacío!", "Debe seleccionar un vehículo");
  }

  static showEmptyMontoDialog() {
    _BaseDialogs.showInformationDialog("¡El campo monto está vacío!",
        "Debe ingresar el importe o los kw que desea cargar");
  }

  static Future showResetPasswordDialog(
      BuildContext context, String email) async {
    ResetPasswordDialogResults? resetPasswordDialogResult;

    // show reset password confirmation dialog
    resetPasswordDialogResult = await Get.dialog<ResetPasswordDialogResults>(
        AlertDialog(
            title: Text("¿Desea reiniciar la contraseña de $email?"),
            content: Text(
                "Enviaremos un mail al correo ingresado con un enlace para reiniciar su contraseña"),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            actions: [
          TextButton(
              child: Text(
                "Si",
                style: TextStyle(color: kOTTAOrange),
              ),
              onPressed: () async {
                try {
                  await AppServices.auth.sendPasswordResetEmail(email: email);
                  Get.back(result: ResetPasswordDialogResults.Done);
                } catch (e) {
                  print(e);
                  // if (e?.code == "user-not-found") {
                  //   Get.back(result: ResetPasswordDialogResults.UserNotFound);
                  // } else {
                  //   Get.back(result: ResetPasswordDialogResults.undefinedError);
                  // }
                }
              }),
          TextButton(
            child: Text(
              "No",
              style: TextStyle(color: kOTTAOrange),
            ),
            onPressed: () =>
                Navigator.of(context).pop(ResetPasswordDialogResults.Canceled),
          )
        ]));

    // show dialogs depending the result of previous dialog
    if (resetPasswordDialogResult == ResetPasswordDialogResults.UserNotFound) {
      showUserNotFoundDialog();
    }
    if (resetPasswordDialogResult ==
        ResetPasswordDialogResults.undefinedError) {
      showUndefinedErrorDialog();
    }
    if (resetPasswordDialogResult == ResetPasswordDialogResults.Done) {
      _BaseDialogs.showInformationDialog("Reincio de contraseña enviado",
          "Se ha enviado un correo a $email con un link para el reinicio de su contraseña");
    }
  }

  static showWeakPasswordDialog() {
    _BaseDialogs.showInformationDialog("Password débil",
        "El password debe contener al menos 8 caracteres, máyusculas y números");
  }

  static showConfirmationEmailSentDialog() {
    _BaseDialogs.showInformationDialog(
        "Email de confirmación envidado",
        "Hemos enviado un correo electrónico con un link de confirmación al "
            "correo solicitado para asociar a su cuenta");
  }

  // static Future<bool> showOkCancelDialog(String title, String content,
  //     {Function callback, String buttonOkText, String buttonCancelText}) {
  //   return Get.dialog<bool>(AlertDialog(
  //     title: Text(title),
  //     content: Text(content),
  //     shape: new RoundedRectangleBorder(
  //         borderRadius: new BorderRadius.circular(10.0)),
  //     actions: [
  //       TextButton(
  //         child: Text(
  //           buttonOkText ?? "Ok",
  //           style: TextStyle(color: AppColors.primaryText),
  //         ),
  //         onPressed: () async {
  //           Get.back(result: true);
  //           callback?.call();
  //         },
  //       ),
  //       TextButton(
  //         child: Text(
  //           buttonCancelText ?? "Cancelar",
  //           style: TextStyle(color: AppColors.primaryText),
  //         ),
  //         onPressed: () {
  //           Get.back(result: false);
  //         },
  //       )
  //     ],
  //   ));
  // }
}

class AppServices {
  // static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;
}
