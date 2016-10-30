require "rspec/core/formatters/console_codes"
require "colorize"

class EmojiFormatter

  PROGRESS_ICONS = {
    :example_passed  => "\u{1f600}",
    :example_failed  => "\u{1f621}",
    :example_pending => "\u{1f537}"
  }

  RSpec::Core::Formatters.register self, :start, :example_passed, :example_failed,
    :example_pending, :dump_failures, :dump_summary

  def initialize(output)
    @output = output
  end

  def start(_)
    @output << "\n"
  end

  def example_passed(_)
    push_result(:example_passed)
  end

  def example_failed(_)
    push_result(:example_failed)
  end

  def example_pending(_)
    push_result(:example_pending)
  end

  def dump_failures(notifications)
    @output << "\n\n"
    @output << "Summary: ".colorize(:blue)
    @output << "\n\n"

    notifications.failure_notifications.each_with_index do |notification, i|
      @output << "#{i+1}. #{notification.description}\n"
      @output << "  `rspec #{notification.example.location_rerun_argument}`\n\n"

      notification.colorized_message_lines.each do |line|
        @output << "  #{line}\n"
      end

      notification.colorized_formatted_backtrace.each do |line|
        @output << "  #{line}\n"
      end

      @output << "\n\n"
    end
  end

  def dump_summary(summary)

  end

  def close(notification)
    puts "" # without this we get a % at the end of the line...
  end

  private
  def push_result(type)
    string = PROGRESS_ICONS[type]
    @output << "#{string} "
  end
end
