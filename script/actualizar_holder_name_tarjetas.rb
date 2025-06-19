#!/usr/bin/env ruby
# Script para actualizar el holder_name de todas las tarjetas existentes

require_relative '../server'

Card.includes(account_holder: :user).find_each do |card|
  account = card.account_holder
  user = account&.user
  if user && user.name && user.surname
    nuevo_nombre = "#{user.name} #{user.surname}"
    if card.holder_name != nuevo_nombre
      card.update(holder_name: nuevo_nombre)
      puts "Actualizado holder_name para Card ##{card.id}: #{nuevo_nombre}"
    end
  else
    puts "No se pudo actualizar Card ##{card.id}: usuario o datos incompletos"
  end
end

puts 'Actualización de holder_name completada.'
