class TaskLoggerJob < ApplicationJob
  require 'sidekiq/api'
  queue_as :default
  sidekiq_options retry: 2

  def perform(task)
    msg = "A task was created with the following title: #{task.title}"
    log = Log.create! task_id: task.id, message: msg

    puts log.message  end

  def print_before_enqueue_message
    puts "Printing from inside before_enqueue callback"
  end

  def print_after_enqueue_message
    puts "Printing from inside after_enqueue callback"
  end
end
