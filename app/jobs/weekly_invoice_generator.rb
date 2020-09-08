class WeeklyInvoiceGenerator < ApplicationJob
  queue_as :default

  def perform(id)
    Project.find(id).week_passes
  end
end
