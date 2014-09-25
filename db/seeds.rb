# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Task.delete_all
Task.create(name: 'タスク1', deadline: DateTime.new(2014,9,1,0,0,0))
Task.create(name: 'タスク2', deadline: DateTime.new(2014,10,1,0,0,0))
Task.create(name: 'タスク3', deadline: DateTime.new(2014,11,1,0,0,0))
Task.create(name: 'タスク4', deadline: DateTime.new(2014,12,1,0,0,0))