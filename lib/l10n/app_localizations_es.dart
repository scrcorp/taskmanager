// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'TaskManager';

  @override
  String get mypage_title => 'Mi Página';

  @override
  String get mypage_editProfile => 'Editar Perfil';

  @override
  String get mypage_changePassword => 'Cambiar Contraseña';

  @override
  String get mypage_languageSettings => 'Configuración de Idioma';

  @override
  String get mypage_appInfo => 'Info de la App';

  @override
  String get mypage_logout => 'Cerrar Sesión';

  @override
  String get mypage_logoutConfirm =>
      '¿Estás seguro de que quieres cerrar sesión?';

  @override
  String get mypage_cancel => 'Cancelar';

  @override
  String get mypage_roleManager => 'Gerente';

  @override
  String get mypage_roleAdmin => 'Admin';

  @override
  String get mypage_roleEmployee => 'Empleado';

  @override
  String get nav_home => 'Inicio';

  @override
  String get nav_tasks => 'Mis Tareas';

  @override
  String get nav_notices => 'Avisos';

  @override
  String get notification_title => 'Notificaciones';

  @override
  String get notification_markAllRead => 'Marcar Todo Leído';

  @override
  String get notification_errorLoad =>
      'No se pudieron cargar las notificaciones';

  @override
  String get notification_empty => 'No hay notificaciones';

  @override
  String get attendance_title => 'Asistencia';

  @override
  String get attendance_errorLoad => 'No se pudo cargar la asistencia';

  @override
  String get attendance_clockIn => 'Hora de Entrada';

  @override
  String get attendance_clockOut => 'Hora de Salida';

  @override
  String get attendance_clockInSuccess => 'Entrada registrada';

  @override
  String attendance_clockInFail(String error) {
    return 'Error al registrar entrada: $error';
  }

  @override
  String get attendance_clockOutSuccess => 'Salida registrada';

  @override
  String attendance_clockOutFail(String error) {
    return 'Error al registrar salida: $error';
  }

  @override
  String get attendance_statusBefore => 'Antes de Entrada';

  @override
  String get attendance_statusOnDuty => 'Trabajando';

  @override
  String get attendance_statusCompleted => 'Salida Completada';

  @override
  String get attendance_workHours => 'Horas de Trabajo';

  @override
  String get attendance_buttonClockIn => 'Registrar Entrada';

  @override
  String get attendance_buttonClockOut => 'Registrar Salida';

  @override
  String get notice_errorLoadList => 'No se pudieron cargar los avisos';

  @override
  String get notice_empty => 'No hay avisos';

  @override
  String get notice_detail => 'Detalle de Aviso';

  @override
  String get notice_errorLoad => 'No se pudo cargar el aviso';

  @override
  String get notice_important => 'Importante';

  @override
  String get notice_confirmed => 'Confirmado';

  @override
  String get notice_confirm => 'Confirmar';

  @override
  String get opinion_title => 'Sugerencias';

  @override
  String get opinion_errorLoad => 'No se pudieron cargar las sugerencias';

  @override
  String get opinion_empty => 'No hay sugerencias';

  @override
  String get opinion_inputHint => 'Ingrese su sugerencia...';

  @override
  String get opinion_statusResolved => 'Resuelto';

  @override
  String get opinion_statusInReview => 'En Revisión';

  @override
  String get opinion_statusReceived => 'Recibido';

  @override
  String get home_errorLoad => 'No se pudieron cargar los datos';

  @override
  String get home_pendingTasks => 'Pendientes';

  @override
  String home_unprocessedTasks(int count) {
    return 'Tienes $count tareas pendientes.';
  }

  @override
  String home_userTasks(String name) {
    return 'Tareas de $name';
  }

  @override
  String get home_taskTotal => 'Todos';

  @override
  String get home_taskPending => 'Pendientes';

  @override
  String home_completionRate(String rate) {
    return '$rate% Completado';
  }

  @override
  String get home_sendOpinion => 'Enviar Opinión';

  @override
  String get home_opinionPlaceholder => 'Ingrese su opinión o sugerencia';

  @override
  String get home_recentNotices => 'Avisos Recientes';

  @override
  String get home_viewMore => 'Ver más';

  @override
  String get home_noRecentNotices => 'No hay avisos recientes';

  @override
  String get status_inProgress => 'En Progreso';

  @override
  String get status_done => 'Completado';

  @override
  String get status_todo => 'Pendiente';

  @override
  String get priority_urgent => 'Urgente';

  @override
  String get priority_normal => 'Normal';

  @override
  String get priority_low => 'Baja';

  @override
  String get error_generic => 'Ocurrió un error';

  @override
  String get error_retry => 'Reintentar';

  @override
  String get assignment_detail => 'Detalle de Tarea';

  @override
  String get assignment_errorLoad => 'No se pudo cargar la tarea';

  @override
  String get assignment_dueDate => 'Fecha límite';

  @override
  String get assignment_createdDate => 'Creado';

  @override
  String get assignment_assignees => 'Asignados';

  @override
  String assignment_comments(int count) {
    return 'Comentarios ($count)';
  }

  @override
  String get assignment_commentHint => 'Escribe un comentario...';

  @override
  String assignment_assigneeCount(int count) {
    return '$count personas';
  }

  @override
  String get assignment_myTasks => 'Mis Tareas';

  @override
  String get assignment_errorLoadList => 'No se pudieron cargar las tareas';

  @override
  String get assignment_empty => 'No hay tareas asignadas';

  @override
  String get comment_defaultUser => 'Usuario';

  @override
  String get comment_badgeManager => 'Gerente';

  @override
  String get date_justNow => 'Justo ahora';

  @override
  String date_minutesAgo(int minutes) {
    return 'Hace ${minutes}m';
  }

  @override
  String date_hoursAgo(int hours) {
    return 'Hace ${hours}h';
  }

  @override
  String date_daysAgo(int days) {
    return 'Hace ${days}d';
  }

  @override
  String date_hoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String date_minutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String get checklist_title => 'Lista Diaria';

  @override
  String get checklist_selectPlaceholder => 'Seleccione una lista';

  @override
  String get login_labelUsername => 'Usuario';

  @override
  String get login_labelPassword => 'Contraseña';

  @override
  String get login_buttonLogin => 'Iniciar Sesión';

  @override
  String get login_noAccount => '¿No tienes una cuenta?';

  @override
  String get login_buttonSignup => 'Registrarse';

  @override
  String signup_title(int step) {
    return 'Registro ($step/3)';
  }

  @override
  String get signup_completeTitle => '¡Registro Completado!';

  @override
  String get signup_completeMessage =>
      'Podrás usar el servicio después de la aprobación del administrador.';

  @override
  String get signup_buttonGetStarted => 'Comenzar';

  @override
  String get signup_errorInvalidEmail => 'Ingrese un correo válido';

  @override
  String get signup_successCodeSent => 'Código de verificación enviado';

  @override
  String get signup_errorSendFailed => 'Error al enviar. Intente de nuevo.';

  @override
  String get signup_errorInvalidCode => 'Código de verificación inválido';

  @override
  String get signup_errorVerifyEmail => 'Verifique su correo';

  @override
  String get signup_sectionInfo => 'Ingrese Información';

  @override
  String get signup_labelName => 'Nombre';

  @override
  String get signup_labelEmail => 'Correo';

  @override
  String get signup_labelCompanyCode => 'Código de Empresa';

  @override
  String get signup_labelPasswordConfirm => 'Confirmar Contraseña';

  @override
  String get signup_buttonSignup => 'Registrarse';

  @override
  String get signup_buttonVerifyRequest => 'Solicitar Verificación';

  @override
  String get signup_buttonResend => 'Reenviar';

  @override
  String get signup_buttonVerified => 'Verificado';

  @override
  String get signup_labelVerificationCode => 'Código de 6 dígitos';

  @override
  String get signup_buttonVerify => 'Verificar';

  @override
  String get signup_errorPasswordMismatch => 'Las contraseñas no coinciden';

  @override
  String get signup_successCodeResent => 'Código reenviado';

  @override
  String get emailVerify_title => 'Verificación de Correo';

  @override
  String emailVerify_description(String email) {
    return 'Ingrese el código de 6 dígitos enviado a\n$email.';
  }

  @override
  String get emailVerify_resend => 'Reenviar Código';

  @override
  String get terms_title => 'Términos de Servicio';

  @override
  String get terms_content =>
      'Artículo 1 (Propósito)\nEstos términos regulan las condiciones y procedimientos para usar el servicio TaskManager.\n\nArtículo 2 (Definiciones)\n\"Servicio\" se refiere a la plataforma de gestión de tareas proporcionada por la empresa.\n\nArtículo 3 (Registro)\nEl registro se realiza mediante un código de empresa, y puede requerir aprobación del administrador.\n\nArtículo 4 (Privacidad)\nLa información personal recopilada se utiliza únicamente para proporcionar el servicio.\n\nArtículo 5 (Obligaciones)\nLos usuarios deben usar el servicio con fines laborales.';

  @override
  String get terms_agree => 'Acepto los Términos de Servicio';

  @override
  String get terms_next => 'Siguiente';

  @override
  String get validator_emailRequired => 'Ingrese su correo';

  @override
  String get validator_emailInvalid => 'Formato de correo inválido';

  @override
  String get validator_loginIdRequired => 'Ingrese su usuario';

  @override
  String get validator_loginIdMinLength =>
      'El usuario debe tener al menos 3 caracteres';

  @override
  String get validator_passwordRequired => 'Ingrese su contraseña';

  @override
  String get validator_passwordMinLength =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String validator_fieldRequired(String fieldName) {
    return 'Ingrese $fieldName';
  }

  @override
  String get validator_codeRequired => 'Ingrese el código de verificación';

  @override
  String get validator_codeLength => 'Ingrese un código de 6 dígitos';

  @override
  String get validator_codeDigitsOnly => 'Solo números';

  @override
  String get apiError_unknown => 'Ocurrió un error desconocido';

  @override
  String get apiError_timeout =>
      'Tiempo de respuesta agotado. Intente más tarde.';

  @override
  String get apiError_noConnection => 'Verifique su conexión de red.';

  @override
  String get apiError_cancelled => 'Solicitud cancelada.';

  @override
  String get apiError_network => 'Ocurrió un error de red.';

  @override
  String get apiError_badRequest => 'Solicitud inválida.';

  @override
  String get apiError_unauthorized =>
      'Sesión expirada. Inicie sesión de nuevo.';

  @override
  String get apiError_forbidden => 'Acceso denegado.';

  @override
  String get apiError_notFound => 'Información no encontrada.';

  @override
  String get apiError_conflict => 'Conflicto en la solicitud.';

  @override
  String get apiError_fileTooLarge => 'El archivo es demasiado grande.';

  @override
  String get apiError_tooManyRequests =>
      'Demasiadas solicitudes. Intente más tarde.';

  @override
  String get apiError_server => 'Error del servidor. Intente más tarde.';

  @override
  String apiError_default(int code) {
    return 'Ocurrió un error. (Código: $code)';
  }
}
