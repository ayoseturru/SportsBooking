# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'digest'

  User.create(dni: '49862693G',password: Digest::SHA1.hexdigest('prueba'))
  User.create(dni: '49862694G',password: Digest::SHA1.hexdigest('prueba'))
  User.create(dni: '49862695G',password: Digest::SHA1.hexdigest('prueba'))
  User.create(dni: '49862696G',password: Digest::SHA1.hexdigest('prueba'))
  User.create(dni: '49862697G',password: Digest::SHA1.hexdigest('prueba'))