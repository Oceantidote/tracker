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
client = User.create!(first_name: "Ariel", last_name: "Roberts", position: "Founder", email: "normal@gmail.com", password: '123123')
User.create(admin: true, email: "ife@gmail.com", password: '123123', position: "Developer", first_name: "ife", company: "HD", last_name: "Odugbesan")
puts "Creating projects and lists"
project = Project.create!(user: client, name: "Normal Project", dev_user: me)
quoted_list = List.create!(project: project, payment_type: "qouted", name: "Quoted List")
support_list = List.create!(project: project, payment_type: "support", name: "Support List")
free_list = List.create!(project: project, payment_type: "free", name: "Free List")
puts "creating tasks"
[quoted_list, support_list, free_list].each do |list|
  5.times do
    Task.create!(list: list, name: "test task", description: "test description", completed_by: (0..4).to_a.sample > 1 ? 5.day.from_now : nil)
  end
end

Task.first(10).each do |task|
  Period.create!(user: me, created_at: 1.day.ago, end_time: 1.hour.ago, end_note: 'example note', task: task)
end
Invoice.create!(project: project, total: 30, approved: true)
