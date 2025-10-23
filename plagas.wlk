class Hogar{
  var property nivelMugre
  var property confort
  method esBuena() = nivelMugre <= (confort / 2)

  method recibirAtaqueDe(unaPlaga){
    nivelMugre += unaPlaga.nivelDeDanio()
  }
}

class Huerta{
  var property nivel = nivelHuerta.nivel()
  var property capacidadDeProduccion
  method esBuena() = capacidadDeProduccion > nivel
  method recibirAtaqueDe(unaPlaga){
    var bonus = 0
    if (unaPlaga.transmitenEnfermedad()) {
      bonus = 10
    }
    capacidadDeProduccion -= ((unaPlaga.nivelDeDanio()*0.1) + bonus)
  }
}

object nivelHuerta{
  method nivel() = 70
}

class Mascota{
  var property nivelDeSalud
  method esBuena() = nivelDeSalud > 250
  method recibirAtaqueDe(unaPlaga){
    if (unaPlaga.transmitenEnfermedad()) {
      nivelDeSalud -= unaPlaga.nivelDeDanio()
    }
  }
}

class Barrio{
  const elementos = []
  method agregarElemento(elemento) {
    elementos.add(elemento)
  }
  method esCopado() = elementos.count({e=>e.esBuena()}) > elementos.size()/2
}


class Plaga{
  var property poblacion
  method nivelDeDanio()
  method transmitenEnfermedad() = poblacion >=10
  method atacarA(unElemento){
    self.efectoAtaque()
    unElemento.recibirAtaqueDe(self)
  }
  method efectoAtaque(){
    poblacion = poblacion + (poblacion * 0.1)
  }
}

class PlagaCucarachas inherits Plaga{
  var property pesoPromedio
  override method nivelDeDanio() = poblacion / 2
  override method transmitenEnfermedad() = pesoPromedio >=10 && super() 
  override method efectoAtaque(){
    super()
    pesoPromedio += 2
  }
}

class PlagaPulgas inherits Plaga{
  override method nivelDeDanio() = poblacion * 2
}

class PlagaGarrapatas inherits PlagaPulgas{
  override method efectoAtaque(){
    poblacion = poblacion + (poblacion*0.2)
  }
}

class PlagaMosquitos inherits Plaga{
  override method nivelDeDanio() = poblacion
  override method transmitenEnfermedad() = (poblacion % 3 == 0) && super()
}