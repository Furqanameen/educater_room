
admin  = User.create(first_name: 'Admin', last_name: 'BrightersRoom', email: 'admin@brightersroom.com', password: 'adm!n12E', role: :admin)
author = User.create(first_name: 'Instructor', last_name: 'BrightersRoom', email: 'instructor@brightersroom.com', password: '!nstuct0r', role: :instructor)

puts "Admin Created!"  if admin.present?
puts "Author Created!" if author.present?
