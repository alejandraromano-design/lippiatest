Feature: #Aquí se describe el título
  Aquí se describe el feature
  
  #Aquí se describe el scenario
  Scenario: título del escenario
    Given precondiciones
    When acciones
    Then validaciones
      
  #Aquí se describe el scenario
  Scenario Outline: título del escenario <campo> <campo2>
    Given precondiciones
    When acciones
    Then validaciones
    
    Examples:
      | campo | campo2 |
      | dato  | dato2  |