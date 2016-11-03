require "rspec/core/formatters/console_codes"

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
    example_result(:example_passed)
  end

  def example_failed(_)
    example_result(:example_failed)
  end

  def example_pending(_)
    example_result(:example_pending)
  end

  def dump_failures(notifications)
    @output << "\n\n"

    notifications.failure_notifications.each_with_index do |notification, i|
      data = { i: i + 1, desc: notification.description }
      @output << "%4<i>s) %<desc>s\n" % data
      @output << "      `bundle exec rspec #{notification.example.location_rerun_argument}`\n\n"

      notification.colorized_message_lines.each do |line|
        @output << "      #{line}\n"
      end

      notification.colorized_formatted_backtrace.each do |line|
        @output << "      #{line}\n"
      end

      @output << "\n\n"
    end
  end

  def dump_summary(summary)
    final_stats = "#{summary.examples.count} examples:\
 #{summary.failed_examples.count} #{PROGRESS_ICONS[:example_failed]}   \
 #{summary.pending_examples.count} #{PROGRESS_ICONS[:example_pending]} "
    @output << final_stats
    puts "" # without this we get a % at the end of the output...
  end

  private
  def example_result(type)
    string = PROGRESS_ICONS[type]
    @output << "#{string} "
  end
end
