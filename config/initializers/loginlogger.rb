class LoginLogger < Logger
  def format_message(severity, timestamp, progname, msg)
    "#{timestamp.to_formatted_s(:db)} #{severity} #{msg}\n"
  end
end
login_logfile = File.open("#{Rails.root}/log/login.log", 'a')
login_logfile.sync = true
LOGIN_LOG = LoginLogger.new(login_logfile)
