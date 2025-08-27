@Web @Profile @Profile @Regression @ModuloC
Feature: Validacion de datos de perfil

  @Smoke @Automated 
  Scenario Outline: Visualizar el perfil del usuario <usuario> ale prueba
    Given el cliente se loguea con el usuario de <usuario>
    And el cliente hace click en el menu del avatar
    When se dirige al desplegable Perfil
    Then se visualizan los datos <datos> de perfil del usuario
    And se verifica que el campo email esta deshabilitado
    And se verifica que el boton <boton> esta deshabilitado
    @ES
    Examples:
      | usuario        | datos                                                                                                   | boton   |
      | automation     | name:AutomationToken,lastname:UserToken,email:automationltm@gmail.com,username:automation.ltm,rol:Admin | Guardar |
    @EN
    Examples:
      | usuario        | datos                                                                                                   | boton |
      | automation     | name:AutomationToken,lastname:UserToken,email:automationltm@gmail.com,username:automation.ltm,rol:Admin | Save  |

  @Smoke @ResetAutomationCredentials @Automated
  Scenario Outline: Asignar un username existente (<idioma>)
    Given el cliente se loguea con el usuario de credentials
    And el cliente hace click en el menu del avatar
    And el cliente se encuentra en la pantalla de Perfil
    And el idioma del sistema está en <idioma>
    When edita el campo Username <username> de Perfil
    And hace click en el boton Guardar de Perfil
    Then aparece una alerta en la parte superior derecha con el mensaje: <mensaje>
    And se verifico que se no se modifico el Nombre De Usuario <username>

    @ES
    Examples:
      | idioma | username       | mensaje                                       |
      | ES     | automation.ltm | Ya existe un perfil con ese nombre de usuario |

    @EN
    Examples:
      | idioma | username       | mensaje                        |
      | EN     | automation.ltm | User exists with same username |

  @ResetearFotoPerfil @Automated
  Scenario Outline: Adjuntar imagen a mi perfil exitosamente (<idioma>)
    Given el cliente está logueado con el usuario de automation
    And el cliente hace click en el menu del avatar
    And el cliente se encuentra en la pantalla de Perfil
    And el idioma del sistema está en <idioma>
    When adjunta el archivo <archivo>
    Then aparece una alerta en la parte superior derecha con el mensaje: <mensaje>
    And se visualiza la imagen del perfil actualizada

    @ES
    Examples:
      | idioma | archivo     | mensaje                     |
      | ES     | archivo.jpg | Archivo adjuntado con exito |

    @EN
    Examples:
      | idioma | archivo     | mensaje                    |
      | EN     | archivo.jpg | File attached successfully |


  @Automated
  Scenario Outline: Adjuntar imagen (<archivo>) incompatible de perfil (<idioma>)
    Given el cliente está logueado con el usuario de automation
    And el cliente hace click en el menu del avatar
    And el cliente se encuentra en la pantalla de Perfil
    And el perfil tiene una imagen previamente cargada
    And el idioma del sistema está en <idioma>
    When adjunta el archivo <archivo>
    Then aparece una alerta en la parte superior derecha con el mensaje: <mensaje>
    And se visualiza la imagen previamente cargada

    @ES
    Examples:
      | idioma | archivo     | mensaje                      |
      | ES     | archivo.mov | Tipo de archivo no soportado |
      | ES     | archivo.pdf | Tipo de archivo no soportado |
      | ES     | archivo.ppt | Tipo de archivo no soportado |

    @EN
    Examples:
      | idioma | archivo     | mensaje               |
      | EN     | archivo.mov | Unsupported file type |
      | EN     | archivo.pdf | Unsupported file type |
      | EN     | archivo.ppt | Unsupported file type |


  @Automated @ToBeAutomated #Card 3148
  Scenario Outline: Guardar campos del formulario vacíos (<idioma>)
    Given el cliente se loguea con el usuario de keycloak
    And el cliente hace click en el menu del avatar
    And el cliente se encuentra en la pantalla de Perfil
    And el idioma del sistema está en <idioma>
    When El cliente edita el campo Nombre <nombre> de Perfil y lo borra
    And El cliente edita el campo Apellido <apellido> de Perfil y lo borra
    And se edita el campo nombre de Usuario <username> de Perfil y lo borra
    Then se verifica que el boton <boton> esta deshabilitado
    And verifica que el mensaje de error <mensaje> aparece para 3 campos

    @ES
    Examples:
      | idioma | mensaje                 | nombre             | apellido             | username           | boton   |
      | ES     | Este campo es requerido | NombreDeAutomation | ApellidoDeAutomation | AutomationUsername | Guardar |
      | ES     | Este campo es requerido |                    |                      |                    | Guardar |

    @EN
    Examples:
      | idioma | mensaje        | nombre             | apellido             | username           | boton |
      | EN     | It is required | NombreDeAutomation | ApellidoDeAutomation | AutomationUsername | Save  |
      | EN     | It is required |                    |                      |                    | Save  |

  @EN @ES @Automated
  Scenario: Verificar el boton Descartar en la seccion Perfil
    Given el cliente se loguea con el usuario de credentials
    And el cliente hace click en el menu del avatar
    And el cliente se encuentra en la pantalla de Perfil
    When hace click en el boton Descartar de Perfil
    Then el usuario visualiza la lista de proyectos

  @ChangeUsernameData @Automated
  Scenario Outline: Guardar campos del formulario con caracteres especiales (<idioma>)
    Given el cliente se loguea con el usuario de keycloak
    And el cliente hace click en el menu del avatar
    And el cliente se encuentra en la pantalla de Perfil
    And el idioma del sistema está en <idioma>
    When El cliente edita el campo Nombre <nombre> de Perfil
    And El cliente edita el campo Apellido <apellido> de Perfil
    And edita el campo Username <username> de Perfil
    Then se verifica que el boton <boton> esta deshabilitado
    And verifica que el mensaje de error <mensaje> aparece para 2 campos

    @ES
    Examples:
      | idioma | mensaje          | nombre             | apellido | username | boton   |
      | ES     | Formato inválido | NombreDeAutomation | $%&/()=  | $%&/()=  | Guardar |

    @EN
    Examples:
      | idioma | mensaje        | nombre             | apellido | username | boton |
      | EN     | Invalid format | NombreDeAutomation | $%&/()=  | $%&/()=  | Save  |


  @EditUser @ChangeUsernameData @Automated
  Scenario Outline: Editar datos de usuario con exito
    Given el cliente se loguea con el usuario de keycloak
    And el cliente hace click en el menu del avatar
    And el cliente se encuentra en la pantalla de Perfil
    And el idioma del sistema está en <idioma>
    When edita el campo Nombre <nombre> de Perfil
    And edita el campo Apellido <apellido> de Perfil
    And edita el campo Username <username> de Perfil
    And hace click en el boton Guardar de Perfil
    Then aparece una alerta en la parte superior derecha con el mensaje: <mensaje>
    And valida que se editaron los datos exitosamente

    @ES
    Examples:
      | nombre | apellido  | username       | mensaje        | idioma |
      | Doña   | Nuñez     | DoñaNuñez      | Perfil editado | ES     |
      | Ángel  | Cristóbal | ÁngelCristóbal | Perfil editado | ES     |
    @EN
    Examples:
      | nombre | apellido  | username       | mensaje        | idioma |
      | Doña   | Nuñez     | DoñaNuñez      | Profile edited | EN     |
      | Ángel  | Cristóbal | ÁngelCristóbal | Profile edited | EN     |

  @EditUser @ChangeUsernameData @Smoke @Automated
  Scenario Outline: Acceso a LTM con los mismos datos utilizados en la registración
    Given el cliente se loguea con el usuario de keycloak
    And el cliente hace click en el menu del avatar
    And el cliente se encuentra en la pantalla de Perfil
    And el idioma del sistema está en <idioma>
    And edita el campo Nombre <nombre> de Perfil
    And edita el campo Apellido <apellido> de Perfil
    And edita el campo Username <username> de Perfil
    And hace click en el boton Guardar de Perfil
    And aparece una alerta con el mensaje: Profile edited
    And valida que se editaron los datos exitosamente
    When el cliente hace click en Cerrar sesión
    And el cliente ingresa nuevamente a LTM con las credenciales registradas <username>
    Then el usuario visualiza todos los proyectos en la pantalla de Dashboard

    @ES
    Examples:
      | nombre      | apellido       | username        | idioma |
      | Doña Marisa | Ñáñez Añoranza | DoñaMarisaÑáñez | ES     |

    @EN
    Examples:
      | nombre      | apellido       | username        | idioma |

      | Doña Marisa | Ñáñez Añoranza | DoñaMarisaÑáñez | EN     |
