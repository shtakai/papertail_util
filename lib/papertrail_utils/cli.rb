require 'papertrail_utils'
require 'thor'
require 'open3'
require 'col'
require 'tty-spinner'

STDOUT.sync = true
module PapertrailUtils
  class CLI < Thor
    default_command :search

    option :env, required: true
    option :filename, required: false
    option :min_days, required: false, type: :numeric, default: 2
    desc "search", "search from log"
    long_desc <<-LONGDESC
(bundle exec )papertrail_utils --env=ENV --filename=filename --min_days=2
options:
  env: mandatory: environment name ex: development
  filename: optional: search term on file
   if no option, use term
    papertrail_utils --env=ENV term
  min_days: optional: how long days search log
    default: 2 days

output is sorted by datetime
    LONGDESC
    def search(term='')
      spinner = TTY::Spinner.new("[:spinner] Loading ...", format: :pulse_2)
      spinner.auto_spin
      query = options[:filename] ? make_query(options[:filename]) : term
      command = "papertrail --min-time '#{options[:min_days]} days ago' #{options[:env]} '#{query}'| sort -k1M -k2n -k4"
      o, e, _ = Open3.capture3(command)
      STDOUT.puts Col.plain o
      spinner.stop('Done')
      STDERR.puts e
    end

    no_commands do
      private def make_query(filename)
        query = ''
        File.open(filename) do |f|
          while line = f.gets
            query << line.chomp << ' OR '
          end
        end
        query.sub(/OR\s+\z/, '')
      end
    end
  end
end
