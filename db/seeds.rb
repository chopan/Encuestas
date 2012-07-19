# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


OpcionTipo.create([{:tipo => "radio_button", :descripcion => "Representa un control tipo radio button"}, {:tipo => "check_box", :descripcion => "Representa un control tipo check box, el cual permite seleccionar varias opciones"}, {:tipo => "Abierta", :descripcion => "Permite agregar texto de manera libre"}])
PreguntaTipo.create([{:nombre => "Sencilla", :descripcion => "Solo permite seleccionar una opcion"}, {:nombre => "Multiple", :descripcion => "Permite seleccionar varias respuestas de un grupo de opciones"}, {:nombre => "Abierta", :descripcion => "Permite contestar con texto una pregunta"}])
Usuario.create(:login => "rgonzalez", :apellido_paterno => "Gonzalez", :apellido_materno => "Echavarria", :email => "rgechavarria@gmail.com", :password => "123pum")#, :password_confirmation => "123pum")

