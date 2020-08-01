# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActivityLog.destroy_all
Invoice.destroy_all
TeamMembership.destroy_all
Period.destroy_all
Task.destroy_all
List.destroy_all
Project.destroy_all
User.destroy_all

puts "Creating users"
me = User.create!(first_name: "Leonard", last_name: "Percival", position: "Director", email: "leonardpercival@gmail.com", password: '123123', admin:true)
me.photo.attach(io: File.open('app/assets/images/leo.jpg'), filename: 'leo.jpg')
me.company_logo.attach(io: File.open('app/assets/images/logo.png'), filename: 'logo.png')
client = User.create!(first_name: "Ariel", last_name: "Roberts", position: "Founder", email: "normal@gmail.com", password: '123123')
ife = User.create(admin: true, email: "ife@gmail.com", password: '123123', position: "Developer", first_name: "ife", company: "HD", last_name: "Odugbesan")
ife.photo.attach(io: File.open('app/assets/images/ife.png'), filename: 'ife.png')
ife.company_logo.attach(io: File.open('app/assets/images/logo.png'), filename: 'logo.png')
# puts "Creating projects and lists"
# project = Project.create!(user: client, name: "Normal Project", dev_user: me)
# TeamMembership.create!(user: ife, project: project)
# quoted_list = List.create!(project: project, payment_type: "quoted", name: "Quoted List")
# support_list = List.create!(project: project, payment_type: "support", name: "Support List")
# free_list = List.create!(project: project, payment_type: "free", name: "Free List")
# puts "creating tasks"
# [quoted_list, support_list, free_list].each do |list|
#   5.times do
#     t = Task.create!(
#       list: list,
#       length: (1..120).to_a.sample,
#       name: "Improve SEO",
#       description: "test description",
#       completed_by: (0..4).to_a.sample > 1 ? 5.day.from_now : nil
#     )
#     Period.create!(user: ife, created_at: 1.day.ago, task: t, end_time: 1.day.ago, title: "tweaking breakpoints")
#     Period.create!(user: me, created_at: 1.day.ago, task: t, end_time: 1.day.ago, title: "tweaking breakpoints")
#   end
# end

# Period.create!(user: me, created_at: 1.day.ago, task: Task.first, title: "tweaking breakpoints")
# Period.create!(user: ife, created_at: 1.day.ago, task: Task.first, title: "tweaking breakpoints")
# Invoice.create!(project: project, total: 30, approved: true)
# Invoice.create!(project: project, total: 30, approved: true, due_by: 5.hours.from_now)
# Invoice.create!(project: project, total: 30, approved: true, due_by: 5.hour.ago)
# Invoice.create!(project: project, total: 30, approved: true, due_by: 9.day.from_now)

