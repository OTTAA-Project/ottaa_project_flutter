import 'package:ottaa_project_flutter/core/abstracts/language.dart';

class SpanishLanguage implements Language {
  const SpanishLanguage();

  @override
  String get languageCode => "es";

  @override
  Map<String, String> get translations => {
        "hello_world": "Hola Mundo",
        "we_are_preparing_everything": "Estamos preparando todo...",
        "Hello": "Hola",
        "Continue": "Continuar",
        "Please_register_to": "Por favor regístrese en",
        "Login_with_google": "Acceder con Google",
        "Login_with_facebook": "Acceder con Facebook",
        "Welcome_this_is_ottaa": "Bienvenidos, esto es OTTAA",
        "We_help_thousands_of_children_with_speech_problems_to_communicate_improving_their_quality_of_life":
            "Ayudamos a miles de niños con problemas de habla a comunicarse, mejorando su calidad de vida",
        "Previous": "Anterior",
        "Next": "Siguiente",
        "Thank_you_for_choosing_ottaa_project":
            "Gracias por elegir OTTAA PROJECT",
        "please_enter_some_text": "Por favor ingrese un texto",
        "Name": "Nombre",
        "Gender": "Genero",
        "Date_of_birth": "Fecha de Nacimiento",
        "Lets_get_to_knwo_each_other_first": "Vamos a conocernos primero",
        "We_are_going_to_collect_some_data_to_get_to_know_you_better":
            "Vamos a recolectar algunos datos para conocerte mejor",
        "Launch_short_tutorial": "TUTORIAL CORTO",
        "Do_a_guided_workshop": "HACER UN TALLER GUIADO",
        "Book_a_demo": "RESERVA UNA DEMO",
        "Ottaa_is_a_powerful_communication_tool":
            "OTTAA es una potente\nherramienta de comunicación",
        "We_offer_you_different_options_so_that_you_learn_how_to_use_it_and_get_the_most_out_of_it":
            "Te ofrecemos diferentes opciones para que aprendas a usarla y sques el mayor provecho",
        "Choose_your_avatar": "Escoge tu Avatar",
        "Final_step_join": "Paso final, unete",
        "Create_your_avatar_to_be_able_to_recognize_you_all_the_time":
            "Crea tu Avatar para poder reconocerte todo el tiempo",
        "Create_your_phrase": "CREA TUS FRASES",
        "step1_long":
            "Toca uno o más de los pictogramas para crear una frase tan larga cómo quieras. Los pictogramas se relacionan automáticamente y siempre tendrás un pictograma más para agregar",
        "Talk_to_the_world": "HABLA CON EL MUNDO",
        "step2_long":
            "Una vez creada la frase, toca el logo de OTTAA par hablar en voz alta o usando el ícono de compartir, podrás enviar tu frase a través de las redes sociales más usadas",
        "Access_thousands_of_pictograms": "ACCEDE A MILES DE PICTOGRAMAS",
        "Step3_long":
            "En OTTAA tenés acceso a miles de pictogramas para que hables de lo que quieras. Encuentra la Galería de Pîctos en la esquina inferior izquierda de la pantalla principal",
        "Ready": "Listo",
        "Step4_long":
            "Entra a la selección de juegos para aprender jugando. OTTAA cuenta con juegos didácticos para aprender vocabulario, conceptos y mucho más. Además, pronto habrá más juegos disponibles",
        "Play_and_learn": "JUEGA Y APRENDE",
        "Male": "Masculino",
        "Female": "Femenino",
        "Binary": "Binary",
        "Fluid": "Fluid",
        "Other": "Other",
        "hola_nnos_conozcamos_un_poco": "Hola,\nNos conozcamos un poco",
        "vamos_a_pedirte_cierta_informaci_n_para_nmejorar_tu_experiencia_con_ottaa":
            "Vamos a pedirte cierta información para\nmejorar tu experiencia con OTTAA",
        "check_if_the_info_is_correct_nif_not_change_it_as_you_wish_this_will_help_us_to_personalize_the_app_for_you":
            "Comprueba si la información es correcta,\nsi no, cámbiala como quieras. Esto nos ayudará a personalizar la aplicación para ti.",
        "te_ofrecemos_varias_opciones_para_naprender_a_utilizarla_y_sacarle_el_maximo_provecho":
            "Te ofrecemos varias opciones para\naprender a utilizarla y sacarle el maximo provecho",
        "por_ltimo": "Por Ultimo!",
        "elige_un_personaje_que_nmejor_te_represente":
            "Elige un personaje que  mejor te represente",
        "edit_pictogram": "Editar pictograma",
        "text": "Texto",
        "frame": "Marco",
        "tags": "Tag",
        "keep_your_ottaa_up_to_date": "Mantenga su OTTAA actualizada",
        "account_info": "Informacion de cuenta",
        "account": "Cuenta",
        "account_type": "Tipo de cuenta",
        "current_ottaa_installed": "OTTAA actual instalado",
        "current_ottaa_version": "Versión actual de OTTAA",
        "device_name": "Nombre del dispositivo",
        "contact_support": "Soporte de contacto",
        "edit": "Editar",
        "delete": "Borrar",
        "fitzgerald_key": "clave fitzgerald",
        "actions": "Comportamiento",
        "interactions": "Interacciones",
        "people": "gente",
        "nouns": "Sustantivos",
        "adjectives": "adjetivos",
        "miscellaneous": "Diverso",
        "choose_a_tag": "Elige una ETIQUETA",
        "tags_widget_long_1":
            "Al elegir las ETIQUETAS, necesita predecir mejor cuándo mostrar ciertos pictogramas, según la hora, la ubicación, el calendario o el clima.",
        "text_widget_long_1":
            "Ingrese el texto para decirlo en voz alta, puede ser una sola palabra o una oración completa. ¡Depende de ti!",
        "important": "Importante",
        "do_you_want_to_save_changes": "Quieres guardar los cambios",
        "no": "No",
        "yes": "sí",
        "go_back": "Regresa",
        "choose_an_option": "Elige una opcion",
        "camera": "Cámara",
        "gallery": "Galería",
        "download_from_arasaac": "Descargar desde ARASAAC",
        "tags_will_come_in_next_release":
            "Los TAG aparecerán en la próxima versión",
        "mute": "Silenciar",
        "about_ottaa": "Acerca de OTTAA",
        "configuration": "Configuración",
        "tutorial": "Tutorial",
        "close_application": "Cierra la aplicación",
        "sign_out": "Desconectar",
        "language": "Idioma",
        "ottaa_labs": "Laboratorios OTTAa",
        "language_page_long_1":
            "Usa la inteligencia artificial para generar una oración más rica. Necesitas una conexión a Internet estable.",
        "settings": "Ajustes",
        "SETTINGS": "AJUSTES",
        "pictograms": "Pictogramas",
        "prediction": "Predicción",
        "accessibility": "Accesibilidad",
        "voice_and_subtitles": "Voz y subtítulos",
        "all_phrases": "Todas las frases",
        "search": "Búsqueda",
        "please_enter_a_valid_search": "Por favor ingrese una búsqueda válida",
        "choose_a_picto_to_speak": "Elige un Picto para hablar",
        "we_are_working_on_this_feature":
            "Estamos trabajando en esta funcionalidad",
        "most_used_sentences": "Oraciones más usadas",
        "price_one":
            "Obtenga acceso hoy a todas las funciones útiles que OTTAA Premium tiene para ofrecer por solo 990 ARS al mes.",
        "purchase_subscription": "COMPRAR SUSCRIPCIÓN",
        "sentence_1":
            "Accede a juegos educativos que te permiten evaluar vocabulario de una manera divertida",
        "sentence_2":
            "Use OTTAA Project con escaneo de pantalla, conéctese accesible Botones y mucho más.",
        "sentence_3":
            "Con la versión premium puedes usar el GPS para tener una mejor predicción basada en el comercio o lugar donde te encuentres",
        "whats_the_picto": "¿Cual es el Picto ?",
        "report": "Reporte",
        "game1":
            "Responde a las preguntas eligiendo el pictograma adecuado. ¡Aprende jugando!",
        "match_picto": "Igualar pictogramas",
        "game2": "Adjunta el pictograma correctamente",
        "memory_game": "Juego de memoria",
        "game3": "Prueba tu memoria",
        "play": "JUGAR",
        "select_a_category_to_play": "Seleccione una categoría para jugar",
        "image": "Imagen",
        "share_text":
            "por favor, crea una frase y selecciona el botón de compartir",
        "text_to_speche_engine": "MOTOR DE TEXTO A VOZ",
        "enable_custom_tts": "Habilitar TTS personalizado",
        "speech_rate": "Nivel de conversación",
        "speech_pitch": "Tono de voz",
        "SUBTITLE": "SUBTITULAR",
        "customized_subtitle": "subtítulo personalizado",
        "size": "Tamaño",
        "upperCase": "Mayúsculas",
        "it_allows_uppercase_subtitles": "Permite subtítulos en mayúsculas",
        "login_screen":
            "Hola, bienvenido a OTTAA Project, la primera plataforma de comunicación predictiva para personas con problemas del habla, inicie sesión con su cuenta y complete algunos datos para beneficiarse de nuestra predicción.",
        "ottaa_score": "OTTAA Score",
        "most_used_groups": "Grupos más usados",
        "score_text_1":
            "OTTAA Score es una medida del uso en general de la aplicación, usando datos como uso en los últimos días y promedio de pictos por frase",
        "phrases_last_seven_days": "Frases creadas en los últimos 7 días",
        "pictogram_by_sentence_on_average":
            "Pictogramas por frases en promedio",
        "most_used_phrases": "Frases Mas Usadas",
        "vocabulary": "Vocabulario",
        "add_group": "Añadir grupo",
        "add_pict": "Agregar imagen",
        "galeria_grupos": "Galeria Grupos",
      };
}
