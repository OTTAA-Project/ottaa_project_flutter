## Analytics Implementation

### Types of events

* **Talk**  *-Interaction event*
* **Erase** *- Event related to an erase action*
* **Delete** *- Event related to deleting a pictogram or group*
* **Accessibility** *- Event related to accessibility*
* **Settings**   *- Event related to a setting action*
* **Pictograms** *- Event related to an add or edit action on a pictogram or group*


### Specifications on each type


#### Talk 

| Screen    | Action                      | Name of Event    |
|-----------|-----------------------------|--------------------|
| Principal | Hablar                      | Phrase Without NLG |
| Principal | Hablar Y Borrar             | Talk and Erase     |
| Principal | Hablar en Modo Experimental | Phrase With NLG    |


#### Erase

| Class     | Action | Name of Event |
|-----------|--------|---------------|
| Principal | Borrar | Borrar        |


#### Accessibility

| Screen         | Action                                  | Name of Event                |
|----------------|-----------------------------------------|-------------------------------|
| Principal      | Hablar Con Dispositivo de accesibilidad | Talk with accesibility device |
| Principal      | Hablar Con Barrido de Pantalla          | Talk with Screen Scanning     |
| Principal      | Galeria Grupos                          | Group Galery                  |
| Galeria Grupos | Boton de Accion                         | Select Group                  |
| Galeria Grupos | Boton de Anterior                       | Previous Button               |
| Galeria Grupos | Boton de siguiente                      | Next Button                   |
| Galeria Grupos | Boton de Salir                          | Close Galery Groups           |
| Galeria Pictos | Editar Pictogramas                      | Edit Pictograms               |
| Galeria Pictos | Boton de Anterior                       | Previous Button               |
| Galeria Pictos | Boton de Siguiente                      | Backpress Button              |


#### Settings

| Screen           | Action                      | Name of Event        |
|------------------|-----------------------------|-----------------------|
| Unir Pictogramas | Activar/Desactivar Repetir  | Mute                  |
| Pictogramas      | EditarPictogramas           | Edit Pictograms       |
| Pictogramas      | Tiempo entre clicks         | Time Between Clicks   |
| Pictogramas      | Hablar y borrar             | Talk and erase        |
| Prediccion       | Ubicacion                   | Location              |
| Prediccion       | Pictos Sugeridos            | Suggested Pictograms  |
| Prediccion       | Edad                        | Age User              |
| Prediccion       | Genero                      | Gender User           |
| Accesibilidad    | Mano Habil                  | Skill hand            |
| Accesibilidad    | Barrido de pantalla         | Screen Scanning       |
| Accesibilidad    | Velocidad de Barrido        | Screen Scanning Speed |
| Accesibilidad    | Velocidad del Scroll        | Scroll Speed          |
| Accesibilidad    | Orientacion del Joystick    | Joystick              |
| Accesibilidad    | Control Facial              | Facial Control        |
| Voz Y Subtitulo  | Habilitar TTS Personalizado | Custom TTS            |
| Voz Y Subtitulo  | Subtitulo Personalizado     | Custom Subtitle       |
| Idioma           | Selecciona un idioma        | Language              |
| Idioma           | OTTAA Labs                  | Experimental Mode     |

#### Pictograms

| Screen        | Action                   | Name of Event                           |
|---------------|--------------------------|------------------------------------------|
| Editar Grupos | Asignar Tags             | Hour Tag, Location Tag,GenderTag,Age Tag |
| Editar Grupos | Agregar Pictograma Nuevo | Add Pictogram                            |
| Editar Grupos | Editar Pictograma        | Edit Pictogram                           |
| Editar Grupos | Agregar Grupo Nuevo      | Add Group                                |
| Editar Grupos | Editar Grupo             | Edit Group                               |


#### Touch
| Screen           | Action                               | Name of Event             |
|------------------|--------------------------------------|----------------------------|
| Principal        | Frases Mas Usadas                    | More Used Phrases          |
| Principal        | Compartir Frases                     | Share Phrases              |
| Principal        | Cargar Opciones                      | More Options               |
| Principal        | Silenciar                            | Silence                    |
| Principal        | Ubicacion                            | Location                   |
| Principal        | Galeria Grupos                       | Group Galery               |
| Principal        | Agregar Relacion                     | add Pictogram              |
| Principal        | Eliminar Relacion                    | Delete Pictogram           |
| Principal        | Editar Pictograma                    | Edit Pictogram             |
| Principal        | Entrar a Configuracion               | settings                   |
| Principal        | Entrar al informe                    | Report                     |
| Principal        | Entrar al Acerca de                  | About That                 |
| Principal        | Cerrar Sesion                        | LogOut                     |
| Galeria Grupos   | Agregar Grupo                        | Add Group                  |
| Galeria Grupos   | Bajar Pictogramas                    | Download Pictograms        |
| Galeria Grupos   | Ordenar Grupos                       | Sort Groups                |
| Galeria Grupos   | Editar Grupo                         | Edit Group                 |
| Galeria Grupos   | Eliminar Grupo                       | Delete Group               |
| Editar Grupos    | Probar Texto en voz alta             | Say Pictogram Name         |
| Editar Grupos    | Agregar Imagen                       | Select Custom Picto Image  |
| Editar Grupos    | Seleccionar Categoria del pictograma | Select Pictograms Category |
| Galeria Pictos   | Agregar Pictogramas                  | Add Pictograms             |
| Galeria Pictos   | Editar Pictogramas                   | Edit Pictograms            |
| Galeria Pictos   | Vincular Pictogramas                 | Vinculate Pictograms       |
| Galeria Pictos   | Buscar Pictograma                    | Search Pictogram           |
| Galeria Pictos   | Eliminar Pictograma                  | Delete Pictograms          |
| Galeria Pictos   | Boton de Anterior                    | Foward Button              |
| Galeria Pictos   | Boton de Siguiente                   | Next Button                |
| Galeria Pictos   | Boton Salir                          | Backpress Button           |
| Galeria Pictos   | Seleccionar Un pictograma            | Select Pictogram           |
| Galeria Pictos   | Ordenar Pictogramas del grupo        | Sort Pictograms            |
| Vincular         | Guardar Pictogramas vinculados       | Vinculate child            |
| Juegos           | Uso del boton Siguiente              | Next Button                |
| Juegos           | Uso del boton Anterior               | Previous Button            |
| Juegos           | Uso del Boton de Accion              | Select Game                |
| Unir Pictogramas | Boton Score                          | Score Dialog               |
| Unir Pictogramas | Activar/Desactivar Ayuda             | Help Action                |
| Unir Pictogramas | Activar/Desactivar Repetir           | Mute                       |
| Cual es el picto | BotonScore                           | Score Dialog               |
| Cual es el picto | Activar/Desactivar Ayuda             | Help Action                |
| Cual es el picto | Silenciar Cancion                    | Mute                       |
| LoginActivity    | Seleccionar el boton de singin       | singIn                     |
| LoginActivityStep2 | Voy al paso 3 del tutorial | Next1 |
| LoginActivityStep2 |vuelvo al login| Back1 |
| LoginActivityStep2 | llamo al calendario | calendarButton |
| LoginActivityStep3 | paso al activity siguiente| Next2 |
| LoginActivityStep3 | paso al activity anterior | Back2  |
| LoginActivityStep3 | voy al tutorial desde el login | ButtonTutorial |
| LoginActivityStep3 | voy al tutorial desde el login | ButtonTutorial |
| LoginActivityStep3 | voy al workshop desde el login | ButtonAutoWorkShop |
| LoginActivityStep3 | Reservo una charla | ButtonBookDemo |
| LoginActivityAvatar |salgo del login a la ventana principal | Next3 |
| LoginActivityAvatar |vuelvo al paso 3 del tutorial | Back3 |
| LoginActivityAvatar | elije tu avatar | buttonSelectAvatarSource |
| LoginActivityStep3 | elije tu foto | buttonSelectCameraSource |
| LoginActivityStep3 | elije una  foto  de la galeria| buttonGalerySource |
| LoginActivityStep3 | elije tu foto | buttonGalerySource |
| LoginActivityStep3 | abre el dialogo para usar el avatar o seleccionar una foto | buttonSelectAvatarSource |
| VincularFrases | ir a la frase anterior | Favorite Phrases UpButton |
| VincularFrases | ir a la frase siguiente | Favorite Phrases DownButton |
| VincularFrases | volver a la pantall principal sin guardar las frases favoritas | Favorite Phrases BackButton |
| VincularFrases | volver a la pantall principal guardando las frases favoritas | SaveFavoritePhrases |
