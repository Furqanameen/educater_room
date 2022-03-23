
admin  = User.create(first_name: 'Admin', last_name: 'educatersRoom', email: 'admin@educatersroom.com', password: 'adm!n12E', role: :admin)
author = User.create(first_name: 'Instructor', last_name: 'educatersRoom', email: 'instructor@educatersroom.com', password: '!nstuct0r', role: :instructor)

puts "Admin Created!"  if admin.present?
puts "Author Created!" if author.present?
