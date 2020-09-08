namespace :weekly_invoices do
  desc "Creating invoices for developer approval"
  task generate: :environment do
    Project.find_each do |project|
      WeeklyInvoiceGenerator.perform_later(project.id)
    end
  end
end
